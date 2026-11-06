import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHoldingsPage extends BasePage {
  readonly heading: Locator
  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Holding details',
      exact: true
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
    panelId: string,
    expectedDetails: Record<string, string>[]
  ) {
    const table = this.page.locator(`#${panelId} table`)
    const rows = table.locator('tbody tr')

    await expect(table.locator('thead th')).toHaveText(
      Object.keys(expectedDetails[0])
    )
    await expect(rows).toHaveCount(expectedDetails.length)

    await Promise.all(
      expectedDetails.map((detail, index) => {
        // Matches the start of each cell as Breed also has visually hidden text, e.g. "HER, Hereford"
        const expectedCells = Object.values(detail).map(
          (value) => new RegExp(String.raw`^${value}\b`)
        )
        return expect(rows.nth(index).locator('td')).toHaveText(expectedCells)
      })
    )
  }
}
