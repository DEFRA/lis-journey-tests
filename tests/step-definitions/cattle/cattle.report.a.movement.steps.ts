import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'
import { resolveDisplayDate, resolveInputDate } from '../../utils/dates'

When(
  'I select Report a cattle movement',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await lisFrontOfficeCattleHoldingOverviewPage.reportCattleMovementLink.click()
  }
)

When(
  'I select {string} and continue',
  async (
    { lisFrontOfficeOnOrOffMovementPage },
    movementType: 'On movement' | 'Off movement'
  ) => {
    await expect(lisFrontOfficeOnOrOffMovementPage.heading).toBeVisible()
    await lisFrontOfficeOnOrOffMovementPage.submitMovementDetails(movementType)
  }
)

When(
  'I submit movement details',
  async ({ lisFrontOfficeMovementDetailsPage }, dataTable: DataTable) => {
    await expect(lisFrontOfficeMovementDetailsPage.heading).toBeVisible()
    await lisFrontOfficeMovementDetailsPage.submitMovementDetails(
      dataTable.hashes().map((animal) => ({
        earTag: animal['Ear tag number'],
        movementDate: resolveInputDate(animal['Movement date'])
      }))
    )
  }
)

When(
  'I verify the Check movement details page displays the following details',
  async (
    { lisFrontOfficeCheckMovementDetailsPage, page },
    dataTable: DataTable
  ) => {
    // Wait for the page to load before reloading, so the reload doesn't catch the previous page
    await expect(lisFrontOfficeCheckMovementDetailsPage.heading).toBeVisible()
    await page.reload()
    await expect(lisFrontOfficeCheckMovementDetailsPage.heading).toBeVisible()
    const expectedDetails = Object.fromEntries(
      dataTable
        .rows()
        .map(([field, value]) => [field, resolveDisplayDate(value)])
    )
    await lisFrontOfficeCheckMovementDetailsPage.verifySummaryDetails(
      expectedDetails
    )
  }
)

When(
  'I send my movement report',
  async ({ lisFrontOfficeSubmitMovementReportPage }) => {
    await expect(lisFrontOfficeSubmitMovementReportPage.heading).toBeVisible()
    await lisFrontOfficeSubmitMovementReportPage.acceptAndSendButton.click()
  }
)

Then('I confirm the Movement has been reported', async ({ page }) => {
  await expect(page.getByText('Movement reported')).toBeVisible()
})

When(
  'I select change for {string}',
  async ({ lisFrontOfficeCheckMovementDetailsPage }, sectionName: string) => {
    await lisFrontOfficeCheckMovementDetailsPage.clickChangeLink(sectionName)
  }
)

When(
  'I remove {string}',
  async ({ lisFrontOfficeMovementDetailsPage }, animal: string) => {
    await expect(lisFrontOfficeMovementDetailsPage.heading).toBeVisible()
    await lisFrontOfficeMovementDetailsPage.removeAnimals([animal])
  }
)

When(
  'I select Back from the Check movement details page',
  async ({ lisFrontOfficeMovementDetailsPage }) => {
    await lisFrontOfficeMovementDetailsPage.backLink.click()
  }
)

When(
  'the previously entered movement animal details are still populated:',
  async ({ lisFrontOfficeMovementDetailsPage }, dataTable: DataTable) => {
    await lisFrontOfficeMovementDetailsPage.verifyInputValues(
      dataTable.rowsHash(),
      {
        'Ear tag number': lisFrontOfficeMovementDetailsPage.earTagInput,
        'Movement date': lisFrontOfficeMovementDetailsPage.dateInput
      }
    )
  }
)
