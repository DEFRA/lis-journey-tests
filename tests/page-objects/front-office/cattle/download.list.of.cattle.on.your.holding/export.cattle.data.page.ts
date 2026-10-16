import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export type CattleExportColumn =
  | 'cph'
  | 'earTagNumber'
  | 'dateOfBirth'
  | 'dateOfRegistration'
  | 'onHoldingDate'
  | 'sex'
  | 'breedName'
  | 'breedCode'
  | 'status'
  | 'damType'
  | 'geneticDamEarTagNumber'
  | 'surrogateDamEarTagNumber'
  | 'sireEarTagNumber'
  | 'sireName'

type DateParts = {
  day: string
  month: string
  year: string
}

export type CattleExportOptions = {
  columns: CattleExportColumn[]
  dateRange?: {
    from?: DateParts
    to?: DateParts
  }
  fileFormat: 'csv' | 'xlsx'
}

export class LisFrontOfficeExportCattleDataPage extends BasePage {
  readonly heading: Locator
  readonly columns: Locator
  readonly csvRadio: Locator
  readonly excelRadio: Locator
  readonly downloadButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Download a list of cattle on your holding'
    })
    this.columns = page.locator('input[name="columns"]')
    this.csvRadio = page.getByRole('radio', { name: 'CSV', exact: true })
    this.excelRadio = page.getByRole('radio', { name: 'Excel (.xlsx)' })
    this.downloadButton = page.getByRole('button', { name: 'Download' })
  }

  private async fillDate(prefix: 'date-from' | 'date-to', date?: DateParts) {
    await this.page.locator(`#${prefix}-day`).fill(date?.day ?? '')
    await this.page.locator(`#${prefix}-month`).fill(date?.month ?? '')
    await this.page.locator(`#${prefix}-year`).fill(date?.year ?? '')
  }

  async checkAllColumns() {
    const columnCount = await this.columns.count()
    for (let index = 0; index < columnCount; index++) {
      const checkbox = this.columns.nth(index)
      if (!(await checkbox.isChecked())) {
        await checkbox.check()
      }
    }
  }

  async uncheckAllColumns() {
    const columnCount = await this.columns.count()
    for (let index = 0; index < columnCount; index++) {
      const checkbox = this.columns.nth(index)
      if (await checkbox.isChecked()) {
        await checkbox.uncheck()
      }
    }
  }

  async downloadCattleData(options: CattleExportOptions) {
    if (options.columns.length === 0) {
      throw new Error('Select at least one cattle export column')
    }

    await this.uncheckAllColumns()

    for (const column of options.columns) {
      await this.page
        .locator(`input[name="columns"][value="${column}"]`)
        .check()
    }

    await this.fillDate('date-from', options.dateRange?.from)
    await this.fillDate('date-to', options.dateRange?.to)

    if (options.fileFormat === 'csv') {
      await this.csvRadio.check()
    } else {
      await this.excelRadio.check()
    }

    await this.downloadButton.click()
  }
}
