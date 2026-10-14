import { DataTable } from 'playwright-bdd'
import { Given, Then } from '../fixtures/test.fixture'
import { expect } from '@playwright/test'

Given(
  'I am on the LIS Front Office home page',
  async ({ lisFrontOfficeHomePage }) => {
    await lisFrontOfficeHomePage.navigateToHomePage()
  }
)

Then(
  'the LIS Front Office home page should be loaded correctly',
  async function ({ lisFrontOfficeHomePage }) {
    await expect(lisFrontOfficeHomePage.heading).toBeVisible()
    await expect(lisFrontOfficeHomePage.heading).toHaveText(
      'Livestock Information Service (LIS) for cattle'
    )
    await expect(lisFrontOfficeHomePage.startNowLink).toBeVisible()
  }
)

Given(
  'I am on the LIS Back Office home page',
  async ({ lisBackOfficeHomePage }) => {
    await lisBackOfficeHomePage.navigateToHomePage()
  }
)

Then(
  /^the (unauthenticated|authenticated) LIS Back Office home page should be loaded correctly$/,
  async function (
    { lisBackOfficeHomePage, lisBackOfficeIdentityPage },
    authState: string
  ) {
    await expect(lisBackOfficeHomePage.headingCaption).toBeVisible()
    if (authState === 'unauthenticated') {
      await expect(lisBackOfficeIdentityPage.subHeading).toHaveText('Sign in')
      await expect(lisBackOfficeIdentityPage.signInButton).toBeVisible()
    } else {
      await expect(lisBackOfficeHomePage.headingCaption).toHaveText(
        'Livestock back office'
      )
      await expect(lisBackOfficeHomePage.cattleMenuLink).toBeVisible()
      await expect(lisBackOfficeHomePage.profileMenuLink).toBeVisible()
      await expect(lisBackOfficeHomePage.signOutLink).toBeVisible()
    }
  }
)

Given(
  /^I select the (.*) species option from the species list$/,
  async ({ lisFrontOfficeHomePage }, species: string) => {
    await lisFrontOfficeHomePage.selectSpecies(species)
  }
)

Then(
  'I should be informed I have no holdings associated to my account',
  async function ({ lisFrontOfficeHomePage }) {
    await expect(lisFrontOfficeHomePage.heading).toHaveText('My holdings')
    await expect(lisFrontOfficeHomePage.body).toHaveText(
      'No holdings are currently linked to this account.'
    )
  }
)

Then(
  'I should see the following CPH holdings:',
  async function ({ lisFrontOfficeHomePage }, dataTable: DataTable) {
    const expectedCphs = dataTable.rows()
    await lisFrontOfficeHomePage.verifyCphs(expectedCphs)
  }
)

Then('I should not be able to view the CPH holding', async function ({ page }) {
  await expect(page.getByText('Page not found')).toBeVisible()
})
