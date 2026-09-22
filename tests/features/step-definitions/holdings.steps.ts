import { DataTable } from 'playwright-bdd'
import { Then } from '../../fixtures/test.fixture'
import { expect } from '@playwright/test'

Then(
  /^the holding details caption should display "([^"]*)"$/,
  async function (
    { lisFrontOfficeHoldingDetailsPage },
    expectedCaption: string
  ) {
    await expect(lisFrontOfficeHoldingDetailsPage.headingCaption).toHaveText(
      expectedCaption
    )
  }
)

Then(
  'I should see the following holding details for the CPH:',
  async function ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) {
    const expectedDetails = dataTable.hashes()
    await lisFrontOfficeHoldingDetailsPage.verifyHoldingDetails(expectedDetails)
  }
)

Then(
  /^the holding details heading should display "([^"]*)"$/,
  async function (
    { lisFrontOfficeHoldingDetailsPage },
    expectedHeading: string
  ) {
    await expect(lisFrontOfficeHoldingDetailsPage.heading).toHaveText(
      expectedHeading
    )
  }
)

Then(
  /^the "([^"]*)" navigation link should be active$/,
  async function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    await expect(lisFrontOfficeHoldingDetailsPage.verifyTabIsSelected(tabName))
  }
)
