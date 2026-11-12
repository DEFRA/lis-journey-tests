import { expect } from '@playwright/test'
import { Then, When } from '../fixtures/test.fixture'

// Generic steps for the Cattle API. Requests and responses are handled by
// CattleApiClient (tests/features/support/api/cattle.api.client.ts)

When(
  'I send a GET request to {string} on the Cattle API',
  async ({ cattleApiClient }, path: string) => {
    await cattleApiClient.send('GET', path)
  }
)

When(
  'I send a GET request to {string} on the Cattle API without the API key',
  async ({ cattleApiClient }, path: string) => {
    await cattleApiClient.send('GET', path, { apiKey: 'missing' })
  }
)

When(
  'I send a GET request to {string} on the Cattle API with an invalid API key',
  async ({ cattleApiClient }, path: string) => {
    await cattleApiClient.send('GET', path, { apiKey: 'invalid' })
  }
)

When(
  'I send a GET request to {string} on the Cattle API without a request ID',
  async ({ cattleApiClient }, path: string) => {
    await cattleApiClient.send('GET', path, { withRequestId: false })
  }
)

// Builds a search of the given length, so long searches don't clutter the feature file
When(
  'I search holdings on the Cattle API with {int} characters',
  async ({ cattleApiClient }, length: number) => {
    await cattleApiClient.send(
      'GET',
      `/v1/holdings?search=${'a'.repeat(length)}`
    )
  }
)

// The JSON body goes in a doc string (""") under the step
When(
  'I send a POST request to {string} on the Cattle API with:',
  async ({ cattleApiClient }, path: string, body: string) => {
    await cattleApiClient.send('POST', path, { body })
  }
)

Then(
  'the Cattle API responds with status {int}',
  ({ cattleApiClient }, status: number) => {
    expect(cattleApiClient.status).toBe(status)
  }
)

Then(
  'the Cattle API responds with status {int} and the response contains {string}',
  ({ cattleApiClient }, status: number, text: string) => {
    expect(cattleApiClient.status).toBe(status)
    expect(cattleApiClient.body).toContain(text)
  }
)

Then(
  'the Cattle API responds with status {int} and the response is {string}',
  ({ cattleApiClient }, status: number, expected: string) => {
    expect(cattleApiClient.status).toBe(status)
    expect(cattleApiClient.body.trim()).toBe(expected)
  }
)

// A top-level field, e.g. "pageSize" or "earTag"
Then(
  'the Cattle API response field {string} is {string}',
  ({ cattleApiClient }, field: string, expected: string) => {
    const json = cattleApiClient.json() as Record<string, unknown>
    expect(String(json[field])).toBe(expected)
  }
)

Then(
  'the Cattle API response has {int} items',
  ({ cattleApiClient }, count: number) => {
    expect(cattleApiClient.items()).toHaveLength(count)
  }
)

// The list must not be empty, so a filter that matches nothing can't pass by mistake.
// Ignores case, so "female" matches "Female"
Then(
  'every item in the Cattle API response has {string} equal to {string}',
  ({ cattleApiClient }, field: string, expected: string) => {
    const items = cattleApiClient.items()
    expect(items.length).toBeGreaterThan(0)
    for (const item of items) {
      expect(String(item[field]).toLowerCase()).toBe(expected.toLowerCase())
    }
  }
)

Then(
  'every item in the Cattle API response has {string} containing {string}',
  ({ cattleApiClient }, field: string, expected: string) => {
    const items = cattleApiClient.items()
    expect(items.length).toBeGreaterThan(0)
    for (const item of items) {
      expect(String(item[field]).toLowerCase()).toContain(
        expected.toLowerCase()
      )
    }
  }
)

Then(
  'the Cattle API response contains {string}',
  ({ cattleApiClient }, text: string) => {
    expect(cattleApiClient.body).toContain(text)
  }
)

// Order is "ascending" or "descending". Needs at least 2 items to prove anything
Then(
  'the Cattle API response items are sorted by {string} in {string} order',
  ({ cattleApiClient }, field: string, order: string) => {
    const values = cattleApiClient.items().map((item) => String(item[field]))
    expect(values.length).toBeGreaterThan(1)
    const direction = order === 'descending' ? -1 : 1
    const sorted = [...values].sort((a, b) => direction * a.localeCompare(b))
    expect(values).toEqual(sorted)
  }
)
