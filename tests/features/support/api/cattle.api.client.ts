import { TestInfo } from '@playwright/test'
import { randomUUID } from 'node:crypto'

// Calls the cattle back-end services directly: the Cattle API (lis-api-cattle) and the
// cattle register BFF (lis-be4fe-cattle-register). Both take the same two headers,
// each with its own API key.
// CDP only lets services and test suites running inside the platform reach them, so locally
// and on GitHub the *_BASE_URL variables point at the lis-dev stack.
// On CDP they are left unset and the address follows ENVIRONMENT (dev or test)
export interface CattleService {
  name: string
  baseUrl: string
  apiKey: string | undefined
  apiKeyVariable: string
}

const cdpUrl = (service: string) =>
  `https://${service}.${process.env.ENVIRONMENT ?? 'dev'}.cdp-int.defra.cloud`

// API keys are only ever read from the env file (.env.dev locally, suite secrets on CDP).
// They are never printed, logged or attached to reports
export const cattleApi: CattleService = {
  name: 'Cattle API',
  baseUrl: (
    process.env.LIS_CATTLE_API_BASE_URL ?? cdpUrl('lis-api-cattle')
  ).replace(/\/$/, ''),
  apiKey: process.env.LIS_CATTLE_API_KEY,
  apiKeyVariable: 'LIS_CATTLE_API_KEY'
}

export const cattleRegisterBff: CattleService = {
  name: 'Cattle register BFF',
  baseUrl: (
    process.env.LIS_CATTLE_REGISTER_BFF_BASE_URL ??
    cdpUrl('lis-be4fe-cattle-register')
  ).replace(/\/$/, ''),
  apiKey: process.env.LIS_CATTLE_REGISTER_BFF_API_KEY,
  apiKeyVariable: 'LIS_CATTLE_REGISTER_BFF_API_KEY'
}

// True when the tests are calling the Cattle API on CDP rather than a local one
export const isCattleApiOnCdp = !process.env.LIS_CATTLE_API_BASE_URL

export type ApiKeyOption = 'valid' | 'missing' | 'invalid'
export type HttpMethod = 'GET' | 'POST' | 'PATCH' | 'DELETE'

export interface CattleServiceRequestOptions {
  body?: string
  apiKey?: ApiKeyOption
  withRequestId?: boolean
}

export class CattleServiceClient {
  status = 0
  body = ''
  // Values kept from earlier responses, e.g. a submission ID.
  // A {name} in a later path or body is replaced with the value saved as "name"
  readonly saved: Record<string, string> = {}
  // Paths to DELETE when the test ends, so each test removes the data it created
  readonly pathsToDelete: string[] = []

  constructor(
    private readonly testInfo: TestInfo,
    private readonly service: CattleService
  ) {}

  // Every endpoint except the health checks and public OpenAPI document needs both headers:
  // x-api-key (401 without it) and x-cdp-request-id (400 without it)
  async send(
    method: HttpMethod,
    path: string,
    {
      body,
      apiKey: keyOption = 'valid',
      withRequestId = true
    }: CattleServiceRequestOptions = {}
  ) {
    const url = `${this.service.baseUrl}${this.fillSavedValues(path)}`
    const requestBody = body && this.fillSavedValues(body)
    const headers: Record<string, string> = {}

    if (keyOption === 'valid') {
      if (!this.service.apiKey) {
        throw new Error(
          `${this.service.apiKeyVariable} is not set in the env file`
        )
      }
      headers['x-api-key'] = this.service.apiKey
    } else if (keyOption === 'invalid') {
      headers['x-api-key'] = 'not-a-valid-api-key'
    }
    if (withRequestId) {
      headers['x-cdp-request-id'] = `lis-journey-tests-${randomUUID()}`
    }
    if (requestBody) {
      headers['content-type'] = 'application/json'
    }

    // Uses Node's fetch rather than Playwright's request on purpose: Playwright records
    // request headers in traces and error logs, which would expose the API key
    let response: Response
    try {
      response = await fetch(url, { method, headers, body: requestBody })
    } catch (error) {
      throw new Error(`${this.service.name} request to ${url} failed`, {
        cause: error
      })
    }

    this.status = response.status
    this.body = await response.text()

    // Printed and attached straight away, so the response can be read even when a check fails.
    // Shows the address and whether a key was sent, never the headers
    const output = [
      `${method} ${url} (API key: ${keyOption})`,
      `${response.status} ${response.statusText}`,
      this.body
    ].join('\n')
    console.log(output)
    await this.testInfo.attach(`${this.service.name} response`, {
      body: output,
      contentType: 'text/plain'
    })
  }

  json(): unknown {
    return JSON.parse(this.body)
  }

  // List endpoints return either an array or a page of results ({ items: [...] })
  items(): Record<string, unknown>[] {
    const json = this.json() as
      Record<string, unknown>[] | { items: Record<string, unknown>[] }
    return Array.isArray(json) ? json : json.items
  }

  // A field anywhere in the response, using dots for nesting and numbers for list positions,
  // e.g. "status", "submissions.0.status" or "data.1.value"
  field(fieldPath: string): unknown {
    return fieldPath
      .split('.')
      .reduce<unknown>(
        (value, key) => (value as Record<string, unknown> | undefined)?.[key],
        this.json()
      )
  }

  // Keeps a response field so later steps can use it as {name}
  saveField(fieldPath: string, name: string) {
    const value = this.field(fieldPath)
    if (value === undefined || value === null) {
      throw new Error(`The response has no "${fieldPath}" to save`)
    }
    if (typeof value === 'object') {
      throw new Error(
        `"${fieldPath}" is a list or object, so it can't be saved as text`
      )
    }
    this.saved[name] = String(value as string | number | boolean)
  }

  // Called when the test ends. Failures are logged rather than thrown,
  // so a clean-up problem doesn't hide the test's own result.
  // Deletes run one at a time, newest first, so anything created
  // inside an earlier record is removed before that record
  async deleteCreatedData() {
    let deletes = Promise.resolve()
    for (const path of [...this.pathsToDelete].reverse()) {
      deletes = deletes.then(() => this.deleteQuietly(path))
    }
    await deletes
  }

  private async deleteQuietly(path: string) {
    try {
      await this.send('DELETE', path)
    } catch (error) {
      console.log(`Clean-up of ${path} failed`, error)
    }
  }

  fillSavedValues(text: string) {
    return text.replaceAll(/\{(\w+)\}/g, (placeholder, name: string) => {
      const value = this.saved[name]
      if (value === undefined) {
        throw new Error(`No value has been saved as "${name}"`)
      }
      return value
    })
  }
}
