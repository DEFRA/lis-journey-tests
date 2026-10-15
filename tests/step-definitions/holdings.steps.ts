import { DataTable } from 'playwright-bdd'
import { Then, When } from '../fixtures/test.fixture'
import { expect } from '@playwright/test'

Then(
  'the holding details caption should display {string}',
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

When(
  'I click the {string} CPH number link',
  async function ({ lisFrontOfficeHoldingDetailsPage }, cphNumber: string) {
    await lisFrontOfficeHoldingDetailsPage.clickOnCphNumberLink(cphNumber)
  }
)

Then(
  'the holding details heading should display {string}',
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
  'the {string} navigation link should be active',
  function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    expect(lisFrontOfficeHoldingDetailsPage.verifyTabIsSelected(tabName))
  }
)

Then(
  'the {string} navigation link is active',
  function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    expect(lisFrontOfficeHoldingDetailsPage.verifyTabIsSelected(tabName))
  }
)

When(
  'I select the {string} navigation link',
  async function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    await lisFrontOfficeHoldingDetailsPage.selectTab(tabName)
  }
)
