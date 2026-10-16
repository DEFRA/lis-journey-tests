import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeRegisterNewCattleBirthPage extends BasePage {
  readonly heading: Locator
  readonly yesRadio: Locator
  readonly noRadio: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Register new cattle births'
    })
    this.yesRadio = page.getByRole('radio', { name: 'Yes' })
    this.noRadio = page.getByRole('radio', { name: 'No' })
  }

  async clickTagNumberLink(reference: string) {
    const link = this.page.getByRole('link', { name: reference })
    await link.click()
  }

  async addAdditionalAnimals(additionalAnimals: 'Yes' | 'No') {
    const radioButton =
      additionalAnimals === 'Yes' ? this.yesRadio : this.noRadio
    await radioButton.check()
    await this.continueButton.click()
  }

  async verifyTagStatus(tagNumber: string, expectedStatus: string) {
    const row = this.page.getByRole('row').filter({
      has: this.page.getByRole('link', {
        name: tagNumber,
        exact: true
      })
    })

    await expect(row.locator('.govuk-tag')).toHaveText(expectedStatus)
  }
}
