import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

When(
  'I select In progress',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await expect(
      lisFrontOfficeCattleHoldingOverviewPage.inProgressAmount
    ).toHaveText('4')
    await lisFrontOfficeCattleHoldingOverviewPage.inProgressLink.click()
  }
)

When(
  'I click the {string} tab',
  async ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) => {
    await lisFrontOfficeHoldingDetailsPage.selectInProgressTab(tabName)
  }
)

Then(
  'I verify the Births table has:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeHoldingDetailsPage.verifyTableDetails(
      'births',
      dataTable.hashes()
    )
  }
)

Then(
  'I verify the Movements table has:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeHoldingDetailsPage.verifyTableDetails(
      'movements',
      dataTable.hashes()
    )
  }
)

Then('I should see the message {string}', async ({ page }, message: string) => {
  await expect(page.getByText(message)).toBeVisible()
})

When(
  'I click on the {string} tag link',
  async ({ lisFrontOfficeHoldingDetailsPage }, tag: string) => {
    await lisFrontOfficeHoldingDetailsPage.clickOnTagLink(tag)
  }
)

Then('I verify the details', async ({ lisFrontOfficeHoldingDetailsPage }) => {
  // Below is placeholder as function is not present in the prototype
  await expect(lisFrontOfficeHoldingDetailsPage.subHeading).toBeVisible()
})
