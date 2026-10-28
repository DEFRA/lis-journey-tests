import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

When(
  'I select Report a cattle death',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await expect(lisFrontOfficeCattleHoldingOverviewPage.heading).toBeVisible()
    await lisFrontOfficeCattleHoldingOverviewPage.reportCattleDeathLink.click()
  }
)

When(
  'I select {string} to is the animal registered',
  async (
    { lisFrontOfficeIsTheAnimalRegisteredPage },
    isRegistered: 'Yes' | 'No'
  ) => {
    await expect(lisFrontOfficeIsTheAnimalRegisteredPage.heading).toBeVisible()
    await lisFrontOfficeIsTheAnimalRegisteredPage.submitAnimalRegistrationStatus(
      isRegistered
    )
  }
)

When(
  'I submit tag {string} and date of death {string}',
  async ({ lisFrontOfficeAnimalDetailsPage }, tag: string, date: string) => {
    await expect(lisFrontOfficeAnimalDetailsPage.heading).toBeVisible()
    await lisFrontOfficeAnimalDetailsPage.submitRegisteredAnimalDetails(
      tag,
      date
    )
  }
)

Then(
  'I verify the Check animal details summary page has:',
  async ({ lisFrontOfficeCheckAnimalDetailsPage }, dataTable: DataTable) => {
    await expect(lisFrontOfficeCheckAnimalDetailsPage.heading).toBeVisible()
    const expectedDetails = [Object.fromEntries(dataTable.rows())]
    await lisFrontOfficeCheckAnimalDetailsPage.verifySummaryDetails(
      expectedDetails
    )
  }
)

Then(
  'I select Continue from the Animal details page',
  async ({ lisFrontOfficeCheckAnimalDetailsPage }) => {
    await lisFrontOfficeCheckAnimalDetailsPage.continueButton.click()
  }
)

Then(
  'I verify death tag number {string} is {string}',
  async (
    { lisFrontOfficeReportCattleDeathsPage },
    tag: string,
    status: string
  ) => {
    await expect(lisFrontOfficeReportCattleDeathsPage.heading).toBeVisible()
    await lisFrontOfficeReportCattleDeathsPage.verifyTagStatus(tag, status)
  }
)

Then(
  'I submit {string} for add more animals for deaths',
  async (
    { lisFrontOfficeReportCattleDeathsPage },
    addMoreAnimals: 'Yes' | 'No'
  ) => {
    await expect(lisFrontOfficeReportCattleDeathsPage.heading).toBeVisible()
    await lisFrontOfficeReportCattleDeathsPage.submitAddMoreAnimals(
      addMoreAnimals
    )
  }
)

Then(
  'I send my cattle death report',
  async ({ lisFrontOfficeSubmitCattleDeathPage }) => {
    await expect(lisFrontOfficeSubmitCattleDeathPage.heading).toBeVisible()
    await lisFrontOfficeSubmitCattleDeathPage.acceptAndSendButton.click()
  }
)
When(
  'I submit valid animal details with {string}, {string},{string}, {string}, and {string}',
  async (
    { lisFrontOfficeAnimalDetailsPage },
    earTag: string,
    dateOfBirth: string,
    dateOfDeath: string,
    sexOfAnimal: 'Male' | 'Female',
    breed: string
  ) => {
    await expect(lisFrontOfficeAnimalDetailsPage.heading).toBeVisible()
    await lisFrontOfficeAnimalDetailsPage.submitUnregisteredAnimalDetails(
      earTag,
      dateOfBirth,
      dateOfDeath,
      sexOfAnimal,
      breed
    )
  }
)

When(
  'I change the {string} of the animal',
  async ({ lisFrontOfficeCheckAnimalDetailsPage }, section: string) => {
    await expect(lisFrontOfficeCheckAnimalDetailsPage.heading).toBeVisible()
    await lisFrontOfficeCheckAnimalDetailsPage.clickChangeLink(section)
  }
)

When(
  'I select Back from the Check animal details page',
  async ({ lisFrontOfficeCheckAnimalDetailsPage }) => {
    await lisFrontOfficeCheckAnimalDetailsPage.backLink.click()
  }
)

Then(
  'the previously entered details are still populated:',
  async ({ lisFrontOfficeAnimalDetailsPage }, dataTable: DataTable) => {
    const values = Object.fromEntries(dataTable.rows())

    await expect(lisFrontOfficeAnimalDetailsPage.animalEarTagInput).toHaveValue(
      values['Animal ear tag number']
    )

    await expect(lisFrontOfficeAnimalDetailsPage.dodInput).toHaveValue(
      values['Date of death']
    )
  }
)
