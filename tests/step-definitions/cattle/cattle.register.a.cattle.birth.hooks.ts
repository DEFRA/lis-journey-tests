import { expect } from '@playwright/test'
import { Before } from '../../fixtures/test.fixture'
import { cattleRegisterBff } from '../../features/support/api/cattle.api.client'

// The single CPH front office user registers births on this holding
const birthHolding = '22/001/0001'

// A holding has one draft registration at a time, which every @cattlebirth scenario shares.
// Before each one, the animals left in the draft by earlier scenarios or failed runs are
// removed through the cattle register BFF, so every scenario starts with an empty draft.
// The @cattlebirth features run one at a time (see the cattle-birth project in
// playwright.config.ts), so this can't clear a draft another scenario is still using
Before({ tags: '@cattlebirth' }, async ({ cattleRegisterBffClient: bff }) => {
  // Without the BFF key (e.g. on CDP until it is added to the suite secrets) nothing is cleared
  if (!cattleRegisterBff.apiKey) {
    console.log(
      'LIS_CATTLE_REGISTER_BFF_API_KEY is not set: the birth draft was not cleared'
    )
    return
  }

  await bff.send('GET', `/submission/${birthHolding}/start`)
  expect(bff.status, 'Starting the birth draft to clear it').toBe(200)
  bff.saveField('submission-id', 'submissionId')

  const animals = (bff.field('animals') ?? []) as { 'animal-id': string }[]
  for (const animal of animals) {
    await bff.send(
      'DELETE',
      `/submission/${birthHolding}/{submissionId}/${animal['animal-id']}`
    )
    expect(bff.status, `Removing ${animal['animal-id']} from the draft`).toBe(
      200
    )
  }
})
