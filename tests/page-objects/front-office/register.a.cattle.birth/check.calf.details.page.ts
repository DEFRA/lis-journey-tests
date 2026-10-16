import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeCheckCalfDetailsPage extends BasePage {
  readonly heading: Locator
  readonly cancelBirthRegistrationButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Check calf details' })
    this.cancelBirthRegistrationButton = page.getByRole('button', {
      name: 'Cancel birth registration'
    })
  }

  async clickChangeLink(sectionName: string) {
    const sectionRow = this.page.locator('.govuk-summary-list__row').filter({
      has: this.page.locator('dt').getByText(sectionName, { exact: true })
    })

    await sectionRow.getByRole('link', { name: /^Change/ }).click()
  }

  async verifySummaryDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []

    for (const detail of expectedDetails) {
      for (const [sectionName, expectedValue] of Object.entries(detail)) {
        const sectionRow = this.page
          .locator('.govuk-summary-list__row')
          .filter({
            has: this.page
              .locator('.govuk-summary-list__key')
              .getByText(sectionName, { exact: true })
          })
        const value = sectionRow.locator('.govuk-summary-list__value')
        assertions.push(expect(value).toHaveText(expectedValue))
      }
    }

    await Promise.all(assertions)
  }
}
