import { Given, Then } from '../../fixtures/test.fixture'
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
      'Livestock Information'
    )
  }
)

Given(
  'I am on the LIS Back Office home page',
  async ({ lisBackOfficeHomePage }) => {
    await lisBackOfficeHomePage.navigateToHomePage()
  }
)

Then(
  'the LIS Back Office home page should be loaded correctly',
  async function ({ lisBackOfficeHomePage }) {
    await expect(lisBackOfficeHomePage.headingCaption).toBeVisible()
    await expect(lisBackOfficeHomePage.headingCaption).toHaveText(
      'Livestock back office'
    )
  }
)
