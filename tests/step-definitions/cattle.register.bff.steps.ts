import { expect } from '@playwright/test'
import { Then, When } from '../fixtures/test.fixture'
import { HttpMethod } from '../features/support/api/cattle.api.client'

// Generic steps for the cattle register BFF (lis-be4fe-cattle-register).
// Requests and responses are handled by CattleServiceClient
// (tests/features/support/api/cattle.api.client.ts).
// A CPH such as "03/202/0021" goes straight into the path, as the BFF takes it as county/parish/holding.
// {submissionId} in a path or body is the ID saved by "I start a submission ..."

When(
  'I send a {word} request to {string} on the cattle register BFF',
  async ({ cattleRegisterBffClient }, method: string, path: string) => {
    await cattleRegisterBffClient.send(method as HttpMethod, path)
  }
)

// The JSON body goes in a doc string (""") under the step
When(
  'I send a {word} request to {string} on the cattle register BFF with:',
  async (
    { cattleRegisterBffClient },
    method: string,
    path: string,
    body: string
  ) => {
    await cattleRegisterBffClient.send(method as HttpMethod, path, { body })
  }
)

When(
  'I send a GET request to {string} on the cattle register BFF without the API key',
  async ({ cattleRegisterBffClient }, path: string) => {
    await cattleRegisterBffClient.send('GET', path, { apiKey: 'missing' })
  }
)

When(
  'I send a GET request to {string} on the cattle register BFF with an invalid API key',
  async ({ cattleRegisterBffClient }, path: string) => {
    await cattleRegisterBffClient.send('GET', path, { apiKey: 'invalid' })
  }
)

When(
  'I send a GET request to {string} on the cattle register BFF without a request ID',
  async ({ cattleRegisterBffClient }, path: string) => {
    await cattleRegisterBffClient.send('GET', path, { withRequestId: false })
  }
)

// Starts a new draft, or continues the holding's existing one, and saves its ID as {submissionId}
When(
  'I start a submission for {string} on the cattle register BFF',
  async ({ cattleRegisterBffClient }, cph: string) => {
    await cattleRegisterBffClient.send('GET', `/submission/${cph}/start`)
    expect(cattleRegisterBffClient.status).toBe(200)
    cattleRegisterBffClient.saveField('submission-id', 'submissionId')
  }
)

// Saves an animal to the started draft. The animal is deleted again when the test ends
When(
  'I save animal {string} to the submission for {string} on the cattle register BFF with:',
  async (
    { cattleRegisterBffClient },
    animalId: string,
    cph: string,
    body: string
  ) => {
    const path = `/submission/${cph}/{submissionId}/${animalId}`
    await cattleRegisterBffClient.send('POST', path, { body })
    expect(cattleRegisterBffClient.status).toBe(200)
    cattleRegisterBffClient.pathsToDelete.push(path)
  }
)

Then(
  'the cattle register BFF responds with status {int}',
  ({ cattleRegisterBffClient }, status: number) => {
    expect(cattleRegisterBffClient.status).toBe(status)
  }
)

Then(
  'the cattle register BFF response contains {string}',
  ({ cattleRegisterBffClient }, text: string) => {
    expect(cattleRegisterBffClient.body).toContain(text)
  }
)

// Dots for nesting and numbers for list positions, e.g. "data.0.value".
// The expected value can use a saved value, e.g. "{submissionId}"
Then(
  'the cattle register BFF response field {string} is {string}',
  ({ cattleRegisterBffClient }, field: string, expected: string) => {
    expect(String(cattleRegisterBffClient.field(field))).toBe(
      cattleRegisterBffClient.fillSavedValues(expected)
    )
  }
)
