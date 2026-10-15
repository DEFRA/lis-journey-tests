import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHoldingsPage extends BasePage {
  public readonly heading: Locator
  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Holding details',
      exact: true
    })
  }

  public async selectTab(tabName: string) {
    const tabToSelect = this.page.getByRole('link', { name: tabName })
    await tabToSelect.waitFor({ state: 'visible' })
    await tabToSelect.click()
  }

  public async verifyTabIsSelected(tabName: string) {
    await expect(
      this.page.getByRole('link', { name: tabName })
    ).toHaveAttribute('aria-current', 'page')
  }

  public async verifyHoldingDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []

    for (const detail of expectedDetails) {
      for (const [key, value] of Object.entries(detail)) {
        const detailLocator = this.page.locator(
          `//dl[contains(@class, 'govuk-summary-list')]//dt[contains(text(), '${key}')]/following-sibling::dd`
        )

        assertions.push(expect(detailLocator).toHaveText(value))
      }
    }

    await Promise.all(assertions)
  }
}
