import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getEnv } from '../../../../../configs/env'
import { getHoldingsSelectors } from '../selectors/front-office/holdings.selectors'

export class LisFrontOfficeHoldingsPage extends BasePage {
  public readonly heading: Locator
  public readonly navigationTab: Locator

  constructor(page: Page) {
    super(page)
    const env = getEnv()
    const selectors = getHoldingsSelectors(env)
    this.navigationTab = page.locator(selectors.navigationTab)
    this.heading = page.locator('.govuk-heading-l')
  }

  public async selectTab(tabName: string) {
    const tabToSelect = this.navigationTab.getByRole('link', { name: tabName })
    await tabToSelect.waitFor({ state: 'visible' })
    await tabToSelect.click()
  }

  public async verifyTabIsSelected(tabName: string) {
    expect(
      await this.navigationTab.getByRole('link', { name: tabName })
    ).toHaveAttribute('aria-current', 'page')
  }

  public async verifyHoldingDetails(expectedDetails: Record<string, string>[]) {
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
