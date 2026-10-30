import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeExportCattleDataPage extends BasePage {
  readonly heading: Locator
  readonly columns: Locator
  readonly fromDateInput: Locator
  readonly toDateInput: Locator
  readonly csvRadio: Locator
  readonly excelRadio: Locator
  readonly pdfRadio: Locator
  readonly downloadButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Download a list of cattle on your holding'
    })
    this.columns = page.locator('input[name="columns"]')
    this.fromDateInput = page.getByRole('textbox', { name: 'From' })
    this.toDateInput = page.getByRole('textbox', { name: 'To' })
    this.csvRadio = page.getByRole('radio', { name: 'CSV', exact: true })
    this.excelRadio = page.getByRole('radio', { name: 'XLSX' })
    this.pdfRadio = page.getByRole('radio', { name: 'PDF' })
    this.downloadButton = page.getByRole('button', { name: 'Download' })
  }

  async enterDateRange(fromDate: string, toDate: string) {
    await this.fromDateInput.fill(fromDate)
    await this.toDateInput.fill(toDate)
  }

  async checkAllColumns() {
    for (const checkbox of await this.columns.all()) {
      await checkbox.check()
      await expect(checkbox).toBeChecked()
    }
  }

  async uncheckAllColumns() {
    for (const checkbox of await this.columns.all()) {
      if (await checkbox.isChecked()) {
        await checkbox.uncheck()
        await expect(checkbox).not.toBeChecked()
      }
    }
  }

  async verifyEachColumnCanBeSelectedAndDeselected() {
    for (const checkbox of await this.columns.all()) {
      await checkbox.check()
      await expect(checkbox).toBeChecked()
      await checkbox.uncheck()
      await expect(checkbox).not.toBeChecked()
    }
  }

  async verifyDefaultColumnSelections() {
    const defaultColumns = new Set([
      'cph',
      'earTagNumber',
      'dateOfBirth',
      'sex'
    ])

    for (const checkbox of await this.columns.all()) {
      const value = await checkbox.getAttribute('value')
      if (value === null) {
        throw new Error('Cattle export column checkbox is missing its value')
      }

      if (defaultColumns.has(value)) {
        await expect(checkbox).toBeChecked()
      } else {
        await expect(checkbox).not.toBeChecked()
      }
    }
  }

  async selectOnlyColumns(columnLabels: string[]) {
    await this.uncheckAllColumns()

    for (const columnLabel of columnLabels) {
      const checkbox = this.page.getByRole('checkbox', {
        name: columnLabel,
        exact: true
      })
      await checkbox.check()
      await expect(checkbox).toBeChecked()
    }
  }

  async selectFileFormat(fileFormat: string) {
    switch (fileFormat.trim().toLowerCase()) {
      case 'csv':
        await this.csvRadio.check()
        break
      case 'xlsx':
        await this.excelRadio.check()
        break
      case 'pdf':
        await this.pdfRadio.check()
        break
      default:
        throw new Error(`Unexpected file format: "${fileFormat}"`)
    }
  }
}
