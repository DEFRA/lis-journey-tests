import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

When(
  'I select In progress',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
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
  'I should be navigated to the {string} page and the web address contains {string}',
  async ({ page }, heading: string, urlFragment: string) => {
    await expect(page.getByRole('heading', { name: heading })).toBeVisible()
    expect(page.url()).toContain(urlFragment)
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
