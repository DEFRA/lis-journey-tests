import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

When(
  'I select {string} on the holding overview',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }, linkName: string) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await lisFrontOfficeCattleHoldingOverviewPage.selectLink(linkName)
  }
)

Then(
  'I verify the Activity page has the CPH number {string} and the Holding name {string}',
  async ({ page }, cphNumber: string, holdingName: string) => {
    await expect(page.getByText(cphNumber)).toBeVisible()
    await expect(page.getByRole('heading', { name: holdingName })).toBeVisible()
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
      lisFrontOfficeHoldingDetailsPage.birthsTable,
      dataTable.hashes()
    )
  }
)

Then(
  'I verify the Movements table has:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeHoldingDetailsPage.verifyTableDetails(
      lisFrontOfficeHoldingDetailsPage.movementsTable,
      dataTable.hashes()
    )
  }
)

Then(
  'I verify the Cattle with errors table has:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeHoldingDetailsPage.verifyTableDetails(
      lisFrontOfficeHoldingDetailsPage.cattleWithErrorsTable,
      dataTable.hashes()
    )
  }
)

Then('I verify the details', async ({ lisFrontOfficeHoldingDetailsPage }) => {
  // Below is placeholder as function is not present in the prototype
  await expect(lisFrontOfficeHoldingDetailsPage.subHeading).toBeVisible()
})

Then(
  'the holding details caption should display {string}',
  async ({ lisFrontOfficeHoldingDetailsPage }, expectedCaption: string) => {
    await expect(lisFrontOfficeHoldingDetailsPage.headingCaption).toHaveText(
      expectedCaption
    )
  }
)

Then(
  'I should see the following holding details for the CPH:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    const expectedDetails = dataTable.hashes()
    await lisFrontOfficeHoldingDetailsPage.verifyHoldingDetails(expectedDetails)
  }
)

When(
  'I click the {string} CPH number link',
  async ({ lisFrontOfficeHoldingDetailsPage }, cphNumber: string) => {
    await lisFrontOfficeHoldingDetailsPage.clickOnCphNumberLink(cphNumber)
  }
)

Then(
  'the holding details heading should display {string}',
  async ({ lisFrontOfficeHoldingDetailsPage }, expectedHeading: string) => {
    await expect(lisFrontOfficeHoldingDetailsPage.heading).toHaveText(
      expectedHeading
    )
  }
)

When(
  'I click the GOV.UK guidance for cattle link',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await lisFrontOfficeCattleHoldingOverviewPage.govUkGuidanceForCattleLink.click()
  }
)

When(
  'I click the Contact BCMS link',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await lisFrontOfficeCattleHoldingOverviewPage.contactBcmsLink.click()
  }
)

Then(
  'the {string} tab should be active',
  function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    expect(lisFrontOfficeHoldingDetailsPage.verifyTabIsSelected(tabName))
  }
)

Then(
  'the {string} tab is active',
  function ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) {
    expect(lisFrontOfficeHoldingDetailsPage.verifyTabIsSelected(tabName))
  }
)

When(
  'I select the {string} tab',
  async ({ lisFrontOfficeHoldingDetailsPage }, tabName: string) => {
    await lisFrontOfficeHoldingDetailsPage.selectTab(tabName)
  }
)

Then(
  'I should see the Cattle overview page with the following details:',
  async (
    { page, lisFrontOfficeCattleHoldingOverviewPage },
    dataTable: DataTable
  ) => {
    const [expected] = dataTable.hashes()

    await expect(page.getByText(expected['CPH'])).toBeVisible()
    await expect(
      page.getByRole('heading', { name: expected['Holding name'] })
    ).toBeVisible()
    await expect(
      lisFrontOfficeCattleHoldingOverviewPage.cattleOnHoldingAmount
    ).toHaveText(expected['Cattle on holding'])
    await expect(
      lisFrontOfficeCattleHoldingOverviewPage.inProgressAmount
    ).toHaveText(expected['In Progress'])
    await expect(
      lisFrontOfficeCattleHoldingOverviewPage.cattleErrorsAmount
    ).toHaveText(expected['Cattle Errors'])
  }
)

When(
  'I click the Cattle on holding link',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await lisFrontOfficeCattleHoldingOverviewPage.cattleOnHoldingLink.click()
  }
)

When(
  'I select the My Profile link',
  async ({ lisFrontOfficeMyProfilePage }) => {
    await lisFrontOfficeMyProfilePage.myProfileLink.click()
  }
)

Then(
  'I verify the Activity table has:',
  async ({ lisFrontOfficeHoldingDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeHoldingDetailsPage.verifyTableDetails(
      lisFrontOfficeHoldingDetailsPage.activityTable,
      dataTable.hashes()
    )
  }
)

When(
  'I select the {string} Activity date link',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }, date: string) => {
    await lisFrontOfficeCattleHoldingOverviewPage.selectLink(date)
  }
)
