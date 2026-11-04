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

// For page-level errors that only appear in the error summary, with no field error
Then(
  'I should see the summary error {string}',
  async ({ lisFrontOfficeRegisterCalfDetailsPage }, errorMessage: string) => {
    await lisFrontOfficeRegisterCalfDetailsPage.validateSummaryErrors([
      errorMessage
    ])
  }
)
