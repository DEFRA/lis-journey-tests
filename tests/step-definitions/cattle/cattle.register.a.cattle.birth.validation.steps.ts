import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'
import { faker } from '@faker-js/faker'
import { resolveInputDate } from '../../utils/dates'

When(
  'I enter calf details with {string}, {string}, {string}, and {string}',
  async (
    { lisFrontOfficeRegisterCalfDetailsPage },
    animalEarTag: string,
    dateOfBirth: string,
    sexOfCalf: 'Male' | 'Female',
    breed: string
  ) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.submitCalfDetails(
      animalEarTag,
      resolveInputDate(dateOfBirth),
      sexOfCalf,
      breed
    )
  }
)

When(
  'I continue from Calf details',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }) => {
    await lisFrontOfficeRegisterCalfDetailsPage.continueButton.click()
  }
)

Then(
  'I should see the errors:',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeRegisterCalfDetailsPage.verifyFieldAndSummaryErrors(
      dataTable.raw().flat()
    )
  }
)

Then(
  'I should see the error {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, errorMessage: string) => {
    await lisFrontOfficeRegisterCalfDetailsPage.verifyFieldAndSummaryErrors([
      errorMessage
    ])
  }
)

When(
  'I enter 255 length strings into the fields and continue',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    const maxLengthString = faker.string.alpha(255)
    await lisFrontOfficeRegisterCalfDetailsPage.enterCalfDetails(
      maxLengthString,
      maxLengthString,
      'Male',
      maxLengthString
    )
  }
)

When(
  'I search for the animal ear tag {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, earTag: string) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.searchAnimalEarTag(earTag)
  }
)

Then(
  'I should see No results found message in the lookup',
  async ({ page }) => {
    await expect(
      page.getByRole('option', { name: 'No results found' })
    ).toBeVisible()
  }
)

When(
  'I search for the Breed {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, breed: string) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.searchBreed(breed)
  }
)
