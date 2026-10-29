import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { DataTable } from 'playwright-bdd'

When(
  'I select Report a cattle movement',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await lisFrontOfficeCattleHoldingOverviewPage.reportCattleMovementLink.click()
  }
)

When(
  'I select {string} and continue',
  async (
    { lisFrontOfficeOnOrOffMovementPage, page },
    movementType: 'On movement' | 'Off movement'
  ) => {
    await page.waitForLoadState('domcontentloaded')
    await expect(lisFrontOfficeOnOrOffMovementPage.heading).toBeVisible()
    await lisFrontOfficeOnOrOffMovementPage.submitMovementDetails(movementType)
  }
)

When(
  'I submit movement details',
  async ({ lisFrontOfficeMovementDetailsPage, page }, dataTable: DataTable) => {
    await page.waitForLoadState('networkidle')
    await expect(lisFrontOfficeMovementDetailsPage.heading).toBeVisible()
    await lisFrontOfficeMovementDetailsPage.submitMovementDetails(
      dataTable.hashes().map((animal) => ({
        earTag: animal['Ear tag number'],
        movementDate: animal['Movement date']
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
    await page.reload()
    await expect(lisFrontOfficeCheckMovementDetailsPage.heading).toBeVisible()
    await lisFrontOfficeCheckMovementDetailsPage.verifyMovementDetails(
      dataTable.hashes().map((detail) => ({
        field: detail.Field,
        expectedValue: detail['Expected value']
      }))
    )
  }
)

When(
  'I continue from Check movement details page',
  async ({ lisFrontOfficeCheckMovementDetailsPage }) => {
    await lisFrontOfficeCheckMovementDetailsPage.continueButton.click()
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
  'I continue from Movement details page',
  async ({ lisFrontOfficeMovementDetailsPage }) => {
    await lisFrontOfficeMovementDetailsPage.continueButton.click()
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
    const values = dataTable.rowsHash()

    await expect(lisFrontOfficeMovementDetailsPage.earTagInput).toHaveValue(
      values['Ear tag number']
    )

    await expect(lisFrontOfficeMovementDetailsPage.dateInput).toHaveValue(
      values['Movement date']
    )
  }
)

When(
  'I select Continue from the Movement details page',
  async ({ lisFrontOfficeMovementDetailsPage }) => {
    await lisFrontOfficeMovementDetailsPage.continueButton.click()
  }
)
