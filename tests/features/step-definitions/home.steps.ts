import { Given, Then } from '../../fixtures/test.fixture'
import { expect } from '@playwright/test'

Given(
  'I am on the LIS Front Office home page',
  async ({ lisFrontOfficeHomePage }) => {
    await lisFrontOfficeHomePage.navigateToHomePage()
  }
)

Then(
  /^the (unauthenticated|authenticated) LIS Front Office home page should be loaded correctly$/,
  async function ({ lisFrontOfficeHomePage }, authState: string) {
    await expect(lisFrontOfficeHomePage.heading).toBeVisible()
    if (authState === 'unauthenticated') {
      await expect(lisFrontOfficeHomePage.heading).toHaveText(
        'Livestock Information'
      )
      await expect(lisFrontOfficeHomePage.startNowLink).toBeVisible()
    } else {
      await expect(lisFrontOfficeHomePage.heading).toHaveText(
        'Livestock Information Service'
      )
      await expect(lisFrontOfficeHomePage.profileMenuLink).toBeVisible()
      await expect(lisFrontOfficeHomePage.cattleMenuLink).toBeVisible()
    }
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
