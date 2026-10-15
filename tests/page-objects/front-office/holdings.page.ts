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
}
