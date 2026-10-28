import { Then, When } from '../fixtures/test.fixture'
import { expect } from '@playwright/test'
import { DataTable } from 'playwright-bdd'

When(
  'I click on the Ear tag number {string} link',
  async ({ lisFrontOfficeAnimalsOnHoldingPage }, earTagNumber: string) => {
    await lisFrontOfficeAnimalsOnHoldingPage.clickOnEarTagNumberLink(
      earTagNumber
    )
  }
)

Then(
  'I should be navigated to the Cattle Details page',
  async ({ lisFrontOfficeCattleDetailsPage }) => {
    await lisFrontOfficeCattleDetailsPage.heading.scrollIntoViewIfNeeded()
    await expect(lisFrontOfficeCattleDetailsPage.heading).toBeVisible()
  }
)

Then(
  'I should see the following Cattle Details:',
  async ({ lisFrontOfficeCattleDetailsPage }, dataTable: DataTable) => {
    const expectedDAnimalsOnHolding = dataTable.hashes()
    await lisFrontOfficeCattleDetailsPage.verifyCattleDetails(
      expectedDAnimalsOnHolding
    )
  }
)
