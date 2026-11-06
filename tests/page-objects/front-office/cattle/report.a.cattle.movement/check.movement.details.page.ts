import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeCheckMovementDetailsPage extends BasePage {
  readonly heading: Locator
  readonly cancelBirthRegistrationButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Check movement details' })
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
}
