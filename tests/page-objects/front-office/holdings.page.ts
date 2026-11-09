import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHoldingsPage extends BasePage {
  readonly heading: Locator
  readonly birthsTable: Locator
  readonly movementsTable: Locator
  readonly activityTable: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Holding details',
      exact: true
    })
    this.birthsTable = page.locator('#births table')
    this.movementsTable = page.locator('#movements table')
    this.activityTable = page.locator('table').filter({
      has: page.getByRole('columnheader', { name: 'Activity', exact: true })
    })
  }

  async selectTab(tabName: string) {
    const tabToSelect = this.page.getByRole('link', { name: tabName })
    await tabToSelect.waitFor({ state: 'visible' })
    await tabToSelect.click()
  }

  async selectInProgressTab(tabName: string) {
    const tabToSelect = this.page.getByRole('tab', { name: tabName })
    await tabToSelect.waitFor({ state: 'visible' })
    await tabToSelect.click()
  }

  async verifyTabIsSelected(tabName: string) {
    await expect(
      this.page.getByRole('link', { name: tabName })
    ).toHaveAttribute('aria-current', 'page')
  }

  async clickOnCphNumberLink(cphNumber: string) {
    const cphNumberLink = this.page.getByRole('link', { name: cphNumber })
    await cphNumberLink.waitFor({ state: 'visible' })
    await cphNumberLink.click()
  }

  async clickOnTagLink(tag: string) {
    const tagLink = this.page.getByRole('link', { name: tag })
    await tagLink.waitFor({ state: 'visible' })
    await tagLink.click()
  }

  async verifyHoldingDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []

    for (const detail of expectedDetails) {
      for (const [key, value] of Object.entries(detail)) {
        const detailRow = this.page.locator('.govuk-summary-list__row').filter({
          has: this.page
            .locator('.govuk-summary-list__key')
            .getByText(key, { exact: true })
        })
        const detailLocator = detailRow.locator('.govuk-summary-list__value')
        assertions.push(expect(detailLocator).toHaveText(value))
      }
    }

    await Promise.all(assertions)
  }

  async verifyTableDetails(
    table: Locator,
    expectedDetails: Record<string, string>[]
  ) {
    const rows = table.locator('tbody tr')

    await expect(table.locator('thead th')).toHaveText(
      Object.keys(expectedDetails[0])
    )
    await expect(rows).toHaveCount(expectedDetails.length)

    await Promise.all(
      expectedDetails.map((detail, index) => {
        // Matches the start of each cell as some cells also have visually hidden text,
        // e.g. Breed "HER, Hereford" or Date "22 Sep 2026 cattle birth registration".
        // Values are escaped so text like "Delegate added (tony.wilson@gmail.com)" matches literally
        const expectedCells = Object.values(detail).map((value) => {
          const escapedValue = value.replaceAll(
            /[.*+?^${}()|[\]\\]/g,
            String.raw`\$&`
          )
          return new RegExp(String.raw`^${escapedValue}(?!\w)`)
        })
        return expect(rows.nth(index).locator('td')).toHaveText(expectedCells)
      })
    )
  }
}
