import { randomUUID } from 'node:crypto'
import { expect } from '@playwright/test'
import { Then, When } from '../fixtures/test.fixture'
import { CattleServiceClient } from '../features/support/api/cattle.api.client'

// Steps for registration bundles: POST /v1/registrations queues a bundle, a worker stores it
// and sends it to CTS, and GET /v1/holdings/{cph}/bundles shows what happened to it.
// Used by cattle.api.registrations.feature and the cattle.api.cts.*.feature files

interface BundleAnimal {
  earTag: string
  status: string
  errors: { errorCode: string }[]
}

interface Bundle {
  clientReference: string
  status: string
  animals: BundleAnimal[]
}

// A bundle has finished once it has one of these statuses
const finishedBundleStatus = /^(complete|complete_with_errors|error)$/

// The bundle this test sent, found in the latest bundles response by its client reference
function sentBundle(client: CattleServiceClient) {
  return (client.json() as Bundle[]).find(
    (bundle) => bundle.clientReference === client.saved.clientReference
  )
}

function bundleAnimal(client: CattleServiceClient, earTag: string) {
  const animal = sentBundle(client)?.animals.find(
    (item) => item.earTag === earTag
  )
  if (!animal) {
    throw new Error(`Animal ${earTag} is not in the bundle`)
  }
  return animal
}

// The body can use {clientReference}, which is made unique for each test
// so the bundle can be found again among those left by earlier runs
When(
  'I send a registration bundle to the Cattle API with:',
  async ({ cattleApiClient }, body: string) => {
    cattleApiClient.saved.clientReference = `lis-journey-tests-${randomUUID()}`
    await cattleApiClient.send('POST', '/v1/registrations', { body })
  }
)

Then(
  'the Cattle API accepts the registration bundle',
  ({ cattleApiClient }) => {
    expect(cattleApiClient.status).toBe(200)
    expect(cattleApiClient.field('status')).toBe('accepted')
  }
)

// A validation ProblemDetails: { title, status: 400, errors: { field: [messages] } }
Then(
  'the Cattle API rejects the registration bundle with the error {string}',
  ({ cattleApiClient }, message: string) => {
    expect(cattleApiClient.status).toBe(400)
    expect(cattleApiClient.field('status')).toBe(400)
    expect(cattleApiClient.field('title')).toBeTruthy()
    expect(JSON.stringify(cattleApiClient.field('errors'))).toContain(message)
  }
)

// Checks the holding's bundles every 5 seconds, for up to 90 seconds, until this test's bundle
// has finished. It goes through the queue, CTS (with a random delay of up to 5 seconds in the fake)
// and the CTS polling job before it gets there
When(
  'the Cattle API has finished processing the bundle for holding {string}',
  async ({ cattleApiClient }, cph: string) => {
    await expect
      .poll(
        async () => {
          await cattleApiClient.send('GET', `/v1/holdings/${cph}/bundles`)
          return sentBundle(cattleApiClient)?.status ?? 'not listed yet'
        },
        {
          message: `The bundle ${cattleApiClient.saved.clientReference} didn't finish processing`,
          timeout: 90_000,
          intervals: [5_000]
        }
      )
      .toMatch(finishedBundleStatus)
  }
)

// A rejected bundle must never reach the queue. Proving something didn't happen needs a wait:
// the queue worker checks for new messages every 10 seconds, so a queued bundle
// would be stored well within 20 seconds
Then(
  'the bundle is never stored for holding {string}',
  async ({ cattleApiClient }, cph: string) => {
    await new Promise((resolve) => setTimeout(resolve, 20_000))
    await cattleApiClient.send('GET', `/v1/holdings/${cph}/bundles`)
    expect(cattleApiClient.status).toBe(200)
    expect(sentBundle(cattleApiClient)).toBeUndefined()
  }
)

Then('the bundle status is {string}', ({ cattleApiClient }, status: string) => {
  expect(sentBundle(cattleApiClient)?.status).toBe(status)
})

Then(
  'animal {string} in the bundle has status {string} with no errors',
  ({ cattleApiClient }, earTag: string, status: string) => {
    const animal = bundleAnimal(cattleApiClient, earTag)
    expect(animal.status).toBe(status)
    expect(animal.errors).toEqual([])
  }
)

Then(
  'animal {string} in the bundle has status {string} with error code {string}',
  ({ cattleApiClient }, earTag: string, status: string, errorCode: string) => {
    const animal = bundleAnimal(cattleApiClient, earTag)
    expect(animal.status).toBe(status)
    expect(animal.errors.map((error) => error.errorCode)).toContain(errorCode)
  }
)
