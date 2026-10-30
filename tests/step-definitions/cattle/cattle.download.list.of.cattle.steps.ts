import { expect } from 'playwright/test'
import { Then, When } from '../../fixtures/test.fixture'

When(
  'I select Download a list of cattle on your holding',
  async ({ lisFrontOfficeCattleHoldingOverviewPage }) => {
    await lisFrontOfficeCattleHoldingOverviewPage.downloadListOfCattleOnYourHoldingLink.click()
  }
)

When(
  'I Download default options',
  async ({ lisFrontOfficeExportCattleDataPage }) => {
    await expect(lisFrontOfficeExportCattleDataPage.heading).toBeVisible()
    await lisFrontOfficeExportCattleDataPage.downloadButton.click()
  }
)

Then('I verify a download has been requested', async ({ page }) => {
  await expect(
    page.getByText(
      'Your export has been requested. This is a prototype - no file has actually been generated.'
    )
  ).toBeVisible()
})

When(
  'I select {string} as file format',
  async ({ lisFrontOfficeExportCattleDataPage }, fileFormat: string) => {
    await lisFrontOfficeExportCattleDataPage.selectFileFormat(fileFormat)
  }
)

When(
  'I enter the date range from {string} to {string}',
  async (
    { lisFrontOfficeExportCattleDataPage },
    fromDate: string,
    toDate: string
  ) => {
    await lisFrontOfficeExportCattleDataPage.enterDateRange(fromDate, toDate)
  }
)

When('I select Download', async ({ lisFrontOfficeExportCattleDataPage }) => {
  await lisFrontOfficeExportCattleDataPage.downloadButton.click()
})

When('I select all columns', async ({ lisFrontOfficeExportCattleDataPage }) => {
  await lisFrontOfficeExportCattleDataPage.checkAllColumns()
})

When(
  'I clear the default options',
  async ({ lisFrontOfficeExportCattleDataPage }) => {
    await lisFrontOfficeExportCattleDataPage.uncheckAllColumns()
  }
)

When(
  'I verify each column can be selected and deselected',
  async ({ lisFrontOfficeExportCattleDataPage }) => {
    await lisFrontOfficeExportCattleDataPage.verifyEachColumnCanBeSelectedAndDeselected()
  }
)

Then(
  'I verify the default column selections',
  async ({ lisFrontOfficeExportCattleDataPage }) => {
    await lisFrontOfficeExportCattleDataPage.verifyDefaultColumnSelections()
  }
)

When(
  'I select only the {string} column',
  async ({ lisFrontOfficeExportCattleDataPage }, columnLabel: string) => {
    await lisFrontOfficeExportCattleDataPage.selectOnlyColumns([columnLabel])
  }
)

When(
  'I select only the {string} and {string} columns',
  async (
    { lisFrontOfficeExportCattleDataPage },
    firstColumnLabel: string,
    secondColumnLabel: string
  ) => {
    await lisFrontOfficeExportCattleDataPage.selectOnlyColumns([
      firstColumnLabel,
      secondColumnLabel
    ])
  }
)
