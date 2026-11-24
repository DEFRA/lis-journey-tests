import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'
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
  'I clear the calf details',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.clearCalfDetails()
  }
)

// Temporary: every test reuses the same user, so the page keeps the sex from an earlier run.
// Remove this step when tests can create their own test users/sessions
When(
  'I clear the sex of the calf',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.clearSexOfCalf()
  }
)

// Temporary: every test reuses the same user, so the page keeps the dam type from an earlier run.
// Remove this step when tests can create their own test users/sessions
When('I clear the dam details', async ({ lisFrontOfficeDamDetailsPage }) => {
  await expect(lisFrontOfficeDamDetailsPage.heading).toBeVisible()
  await lisFrontOfficeDamDetailsPage.clearDamDetails()
})

When(
  'I clear the genetic dam details',
  async ({ lisFrontOfficeGeneticDamDetailsPage }) => {
    await expect(lisFrontOfficeGeneticDamDetailsPage.heading).toBeVisible()
    await lisFrontOfficeGeneticDamDetailsPage.clearGeneticDamDetails()
  }
)

When(
  'I clear the surrogate dam details',
  async ({ lisFrontOfficeSurrogateDamDetailsPage }) => {
    await expect(lisFrontOfficeSurrogateDamDetailsPage.heading).toBeVisible()
    await lisFrontOfficeSurrogateDamDetailsPage.clearSurrogateDamDetails()
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

// GOV.UK Frontend moves focus to the error summary when the page loads with errors
Then('the error summary has focus', async ({ page }) => {
  await expect(page.locator('.govuk-error-summary')).toBeFocused()
})

Then(
  'I should see the error {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, errorMessage: string) => {
    await lisFrontOfficeRegisterCalfDetailsPage.verifyFieldAndSummaryErrors([
      errorMessage
    ])
  }
)

Then(
  'I should see the warning {string}',
  async ({ page }, errorMessage: string) => {
    await expect(page.getByText(errorMessage)).toBeVisible()
  }
)

// For page-level errors that only appear in the error summary, with no field error
Then(
  'I should see the summary error {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, errorMessage: string) => {
    await lisFrontOfficeRegisterCalfDetailsPage.validateSummaryErrors([
      errorMessage
    ])
  }
)
