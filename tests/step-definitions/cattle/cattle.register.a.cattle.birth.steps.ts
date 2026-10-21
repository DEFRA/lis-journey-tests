import { expect } from 'playwright/test'
import { Given, Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

Given('I log into the herokuapp mvp', async ({ page }) => {
  const password = process.env.LIS_HEROKUAPP_PASSWORD
  if (!password) {
    throw new Error(
      'LIS_HEROKUAPP_PASSWORD is required to log into the Heroku MVP'
    )
  }

  await page.goto(
    'https://livestock-traceability-4f1c92f377cb.herokuapp.com/mvp-front-office/v5/my-holdings/holding-overview?holding-id=holding-001'
  )
  await page.getByRole('textbox', { name: 'Password' }).fill(password)
  await page.getByRole('button', { name: 'Continue' }).click()
})

When(
  'I select Register a cattle birth',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await lisFrontOfficeCattleHoldingOverviewPage.registerCattleBirthLink.click()
  }
)

When(
  'I start birth registration process',
  async ({ lisFrontOfficeRegisterCattleBirthPage }) => {
    await lisFrontOfficeRegisterCattleBirthPage.startBirthRegistrationButton.click()
  }
)

Then(
  'I submit valid calf details with {string}, {string}, {string}, {string}, {string}, and {string}',
  async (
    { lisFrontOfficeRegisterCalfDetailsPage },
    earTag: string,
    day: string,
    month: string,
    year: string,
    sex: 'Male' | 'Female',
    breed: string
  ) => {
    await expect(lisFrontOfficeRegisterCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCalfDetailsPage.submitCalfDetails(
      earTag,
      day,
      month,
      year,
      sex,
      breed
    )
  }
)

Then(
  'I submit the dam details as {string}',
  async (
    { lisFrontOfficeDamDetailsPage },
    damDetails: 'calf born via genetic dam' | 'calf born via surrogate dam'
  ) => {
    await expect(lisFrontOfficeDamDetailsPage.heading).toBeVisible()
    await lisFrontOfficeDamDetailsPage.submitDamDetails(damDetails)
  }
)

When(
  'I add the ear tag of the dam as {string}',
  async ({ lisFrontOfficeGeneticDamDetailsPage }, earTag: string) => {
    await expect(lisFrontOfficeGeneticDamDetailsPage.heading).toBeVisible()
    await lisFrontOfficeGeneticDamDetailsPage.submitAnimalEarTagNumber(earTag)
  }
)

When(
  'I add a genetic dam ear tag number as {string} and a surrogate dam ear tag number as {string}',
  async (
    { lisFrontOfficeSurrogateDamDetailsPage },
    geneticDamEarTag: string,
    surrogateDamEarTag: string
  ) => {
    await expect(lisFrontOfficeSurrogateDamDetailsPage.heading).toBeVisible()
    await lisFrontOfficeSurrogateDamDetailsPage.submitGeneticAndSurrogateDamEarTagNumbers(
      geneticDamEarTag,
      surrogateDamEarTag
    )
  }
)

When('I add no sire details', async ({ lisFrontOfficeSireDetailsPage }) => {
  await expect(lisFrontOfficeSireDetailsPage.heading).toBeVisible()
  await lisFrontOfficeSireDetailsPage.submitSireDetails()
})

When(
  'I submit the sire ear tag number as {string}',
  async ({ lisFrontOfficeSireDetailsPage }, sireEarTagNumber: string) => {
    await expect(lisFrontOfficeSireDetailsPage.heading).toBeVisible()
    await lisFrontOfficeSireDetailsPage.submitSireDetails(sireEarTagNumber)
  }
)

When(
  'I add sire details with {string} and {string}',
  async ({ lisFrontOfficeSireDetailsPage }, earTag: string, name: string) => {
    await expect(lisFrontOfficeSireDetailsPage.heading).toBeVisible()
    await lisFrontOfficeSireDetailsPage.submitSireDetails(earTag, name)
  }
)

Then(
  'I verify the Check calf details summary page has:',
  async ({ lisFrontOfficeCheckCalfDetailsPage }, dataTable: DataTable) => {
    await expect(lisFrontOfficeCheckCalfDetailsPage.heading).toBeVisible()
    const expectedDetails = [Object.fromEntries(dataTable.rows())]
    await lisFrontOfficeCheckCalfDetailsPage.verifySummaryDetails(
      expectedDetails
    )
  }
)

When(
  'I select Continue from the Calf details page',
  async ({ lisFrontOfficeCheckCalfDetailsPage }) => {
    await lisFrontOfficeCheckCalfDetailsPage.continueButton.click()
  }
)

Then(
  'I verify tag number {string} is {string}',
  async (
    { lisFrontOfficeRegisterNewCattleBirthPage },
    tag: string,
    status: string
  ) => {
    await expect(lisFrontOfficeRegisterNewCattleBirthPage.heading).toBeVisible()
    await lisFrontOfficeRegisterNewCattleBirthPage.verifyTagStatus(tag, status)
  }
)

Then(
  'I submit the sire name as {string}',
  async ({ lisFrontOfficeSireDetailsPage }, sireName: string) => {
    await expect(lisFrontOfficeSireDetailsPage.heading).toBeVisible()
    await lisFrontOfficeSireDetailsPage.submitSireDetails(undefined, sireName)
  }
)

When(
  'I submit {string} for add more animals',
  async (
    { lisFrontOfficeRegisterNewCattleBirthPage },
    addMoreAnimals: 'Yes' | 'No'
  ) => {
    await expect(lisFrontOfficeRegisterNewCattleBirthPage.heading).toBeVisible()
    await lisFrontOfficeRegisterNewCattleBirthPage.submitAddMoreAnimals(
      addMoreAnimals
    )
  }
)

When(
  'I send my cattle birth report',
  async ({ lisFrontOfficeSubmitCattleRegistrationPage }) => {
    await expect(
      lisFrontOfficeSubmitCattleRegistrationPage.heading
    ).toBeVisible()
    await lisFrontOfficeSubmitCattleRegistrationPage.acceptAndSendButton.click()
  }
)

Then(
  'I verify that {string}',
  async ({ page }, confirmationMessage: string) => {
    await expect(page.getByText(confirmationMessage)).toBeVisible()
  }
)

When(
  'I cancel the cattle birth registration',
  async ({ lisFrontOfficeCheckCalfDetailsPage }) => {
    await expect(lisFrontOfficeCheckCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeCheckCalfDetailsPage.cancelBirthRegistrationButton.click()
  }
)

When(
  'I select {string} on the cancellation confirmation page',
  async (
    { lisFrontOfficeCancelThisRegistrationPage },
    confirmation: 'Continue' | 'Cancel'
  ) => {
    await expect(lisFrontOfficeCancelThisRegistrationPage.heading).toBeVisible()
    await lisFrontOfficeCancelThisRegistrationPage.confirmCancellation(
      confirmation
    )
  }
)

Then(
  'I am returned to Register new cattle births page',
  async ({ lisFrontOfficeRegisterNewCattleBirthPage }) => {
    await expect(lisFrontOfficeRegisterNewCattleBirthPage.heading).toBeVisible()
  }
)

Then(
  'I am returned to Check calf details summary page',
  async ({ lisFrontOfficeCheckCalfDetailsPage }) => {
    await expect(lisFrontOfficeCheckCalfDetailsPage.heading).toBeVisible()
  }
)

When(
  'I click on the tag number {string}',
  async ({ lisFrontOfficeRegisterNewCattleBirthPage }, tag: string) => {
    await lisFrontOfficeRegisterNewCattleBirthPage.clickTagNumberLink(tag)
  }
)

When(
  'I select Cancel on Draft registrations',
  async ({ lisFrontOfficeRegisterCattleBirthPage }) => {
    await lisFrontOfficeRegisterCattleBirthPage.cancelLink.click()
  }
)

When(
  'I select Continue on Draft registrations',
  async ({ lisFrontOfficeRegisterCattleBirthPage }) => {
    await lisFrontOfficeRegisterCattleBirthPage.continueLink.click()
  }
)

When(
  'I confirm the cancellation',
  async ({ lisFrontOfficeCancelDraftRegistrationPage }) => {
    await expect(
      lisFrontOfficeCancelDraftRegistrationPage.heading
    ).toBeVisible()
    await lisFrontOfficeCancelDraftRegistrationPage.cancelDraftButton.click()
  }
)

When(
  'I select Go back on the cancellation confirmation page',
  async ({ lisFrontOfficeCancelDraftRegistrationPage }) => {
    await expect(
      lisFrontOfficeCancelDraftRegistrationPage.heading
    ).toBeVisible()
    await lisFrontOfficeCancelDraftRegistrationPage.goBackLink.click()
  }
)

Then(
  'I am returned to Register cattle births page',
  async ({ lisFrontOfficeRegisterCattleBirthPage }) => {
    await expect(lisFrontOfficeRegisterCattleBirthPage.heading).toBeVisible()
  }
)

When(
  'I verify reference number {string} is {string}',
  async (
    { lisFrontOfficeRegisterCattleBirthPage },
    referenceNumber: string,
    status: string
  ) => {
    await expect(lisFrontOfficeRegisterCattleBirthPage.heading).toBeVisible()
    await lisFrontOfficeRegisterCattleBirthPage.verifyRegistrationStatus(
      referenceNumber,
      status
    )
  }
)

When(
  'I click on reference number {string} from the history registrations',
  async (
    { lisFrontOfficeRegisterCattleBirthPage },
    referenceNumber: string
  ) => {
    await lisFrontOfficeRegisterCattleBirthPage.clickRegistrationHistoryReferenceLink(
      referenceNumber
    )
  }
)

Then(
  'I verify the submission details page has:',
  async ({ lisFrontOfficeSubmissionDetailsPage }, dataTable: DataTable) => {
    await expect(lisFrontOfficeSubmissionDetailsPage.heading).toBeVisible()
    const expectedDetails = Object.fromEntries(dataTable.rows())
    await lisFrontOfficeSubmissionDetailsPage.verifySubmissionDetails(
      expectedDetails
    )
  }
)

Then(
  'I verify the Animals registered table has:',
  async ({ lisFrontOfficeSubmissionDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeSubmissionDetailsPage.verifyRegisteredAnimals(
      dataTable.hashes()
    )
  }
)

Then(
  'I verify tag number {string} is in {string} status',
  async (
    { lisFrontOfficeRegisterNewCattleBirthPage },
    tagNumber: string,
    status: string
  ) => {
    await expect(lisFrontOfficeRegisterNewCattleBirthPage.heading).toBeVisible()
    await lisFrontOfficeRegisterNewCattleBirthPage.verifyTagStatus(
      tagNumber,
      status
    )
  }
)

Then(
  'I change the {string} of the calf',
  async ({ lisFrontOfficeCheckCalfDetailsPage }, sectionName: string) => {
    await expect(lisFrontOfficeCheckCalfDetailsPage.heading).toBeVisible()
    await lisFrontOfficeCheckCalfDetailsPage.clickChangeLink(sectionName)
  }
)
