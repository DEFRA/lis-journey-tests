import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeCattleDetailsPage extends BasePage {
  readonly heading: Locator
  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Cattle details',
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

  async verifyCattleDetails(expectedDetails: Record<string, string>[]) {
    for (const detail of expectedDetails) {
      for (const [key, value] of Object.entries(detail)) {
        const detailLocator = this.page.locator(
          `//dl[contains(@class, 'govuk-summary-list')]//dt[contains(text(), '${key}')]/following-sibling::dd`
        )
        await expect(detailLocator).toHaveText(value)
      }
    }
  }
}
