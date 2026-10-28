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
  async ({ lisFrontOfficeHomePage }) => {
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
  'the {word} LIS Back Office home page should be loaded correctly',
  async (
    { lisBackOfficeHomePage, lisBackOfficeIdentityPage },
    authState: string
  ) => {
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
  'I select the {} species option from the species list',
  async ({ lisFrontOfficeHomePage }, species: string) => {
    await lisFrontOfficeHomePage.selectSpecies(species)
  }
)

Then(
  'I should be informed I have no holdings associated to my account',
  async ({ lisFrontOfficeHomePage, page }) => {
    await expect(lisFrontOfficeHomePage.heading).toHaveText('My holdings')
    await expect(
      page.getByText('No holdings are currently linked to this account.')
    ).toBeVisible()
  }
)

Then(
  'I should see the following CPH holdings:',
  async ({ lisFrontOfficeHomePage }, dataTable: DataTable) => {
    const expectedCphs = dataTable.rows()
    await lisFrontOfficeHomePage.verifyCphs(expectedCphs)
  }
)

Then('I should not be able to view the CPH holding', async ({ page }) => {
  await expect(page.getByText('Page not found')).toBeVisible()
})
