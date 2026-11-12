import { TestInfo } from '@playwright/test'
import { randomUUID } from 'node:crypto'

// Calls the Cattle API (lis-api-cattle) directly.
// CDP only lets services and test suites running inside the platform reach it, so locally and
// on GitHub LIS_CATTLE_API_BASE_URL points at the Cattle API in the lis-dev stack.
// On CDP it is left unset and the address follows ENVIRONMENT (dev or test)
const baseUrl = (
  process.env.LIS_CATTLE_API_BASE_URL ??
  `https://lis-api-cattle.${process.env.ENVIRONMENT ?? 'dev'}.cdp-int.defra.cloud`
).replace(/\/$/, '')

// The API key is only ever read from the env file (.env.dev locally, suite secrets on CDP).
// It is never printed, logged or attached to reports
const apiKey = process.env.LIS_CATTLE_API_KEY

export type ApiKeyOption = 'valid' | 'missing' | 'invalid'

export interface CattleApiRequestOptions {
  body?: string
  apiKey?: ApiKeyOption
  withRequestId?: boolean
}

export class CattleApiClient {
  status = 0
  body = ''

  constructor(private readonly testInfo: TestInfo) {}

  // Every /v1 endpoint needs both headers: x-api-key (401 without it)
  // and x-cdp-request-id (400 without it). /health needs neither
  async send(
    method: 'GET' | 'POST',
    path: string,
    {
      body,
      apiKey: keyOption = 'valid',
      withRequestId = true
    }: CattleApiRequestOptions = {}
  ) {
    const url = `${baseUrl}${path}`
    const headers: Record<string, string> = {}

    if (keyOption === 'valid') {
      if (!apiKey) {
        throw new Error('LIS_CATTLE_API_KEY is not set in the env file')
      }
      headers['x-api-key'] = apiKey
    } else if (keyOption === 'invalid') {
      headers['x-api-key'] = 'not-a-valid-api-key'
    }
    if (withRequestId) {
      headers['x-cdp-request-id'] = `lis-journey-tests-${randomUUID()}`
    }
    if (body) {
      headers['content-type'] = 'application/json'
    }

    // Uses Node's fetch rather than Playwright's request on purpose: Playwright records
    // request headers in traces and error logs, which would expose the API key
    let response: Response
    try {
      response = await fetch(url, { method, headers, body })
    } catch (error) {
      throw new Error(`Cattle API request to ${url} failed`, { cause: error })
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
    await this.testInfo.attach('Cattle API response', {
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
}
