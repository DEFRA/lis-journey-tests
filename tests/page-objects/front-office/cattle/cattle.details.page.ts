import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeCattleDetailsPage extends BasePage {
  readonly heading: Locator
  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Cattle details',
      exact: true
    })
  }

  async verifyCattleDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []

    for (const detail of expectedDetails) {
      for (const [key, value] of Object.entries(detail)) {
        if (key === 'Sire details') {
          const sireDetailsMessage = this.page.getByText(value, {
            exact: true
          })
          assertions.push(expect(sireDetailsMessage).toHaveText(value))
          continue
        }

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
