import { expect } from '@playwright/test'
import { HealthResponse } from '../../types/responses/healthResponse.type'
import { StatusCodes } from 'http-status-codes'
import { EndPoints } from '../../utils/enums'
import { Given, When, Then } from '../../fixtures/test.fixture'
import { LisBackOfficeClient } from '../support/api/lis.back.office.client'
import { LisFrontOfficeClient } from '../support/api/lis.front.office.client'

let client: LisBackOfficeClient | LisFrontOfficeClient
let response: HealthResponse

Given(
  'the LIS Front Office application is running',
  async function ({ lisFrontOfficeClient }) {
    client = lisFrontOfficeClient
  }
)

Given(
  'the LIS Back Office application is running',
  async function ({ lisBackOfficeClient }) {
    client = lisBackOfficeClient
  }
)

When('I check the health endpoint', async function () {
  response = await client.get<HealthResponse>(EndPoints.Health, StatusCodes.OK)
})

Then('I should receive a healthy response', async function () {
  if (
    client instanceof LisBackOfficeClient ||
    client instanceof LisFrontOfficeClient
  ) {
    expect(response).toHaveProperty('message', 'success')
  } else {
    throw new Error('Unknown client type')
  }
})
