import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeRegisterNewCattleBirthPage extends BasePage {
  readonly heading: Locator
  readonly animalsTable: Locator
  readonly yesRadio: Locator
  readonly noRadio: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Register new cattle births'
    })
    // The table is named by its visually hidden caption
    this.animalsTable = page.getByRole('table', {
      name: 'Animals in this registration'
    })
    const addMoreAnimals = page.getByRole('group', { name: 'Add more animals' })
    this.yesRadio = addMoreAnimals.getByRole('radio', { name: 'Yes' })
    this.noRadio = addMoreAnimals.getByRole('radio', { name: 'No' })
  }

  async submitAddMoreAnimals(addMoreAnimals: 'Yes' | 'No') {
    const radioButton = addMoreAnimals === 'Yes' ? this.yesRadio : this.noRadio
    await radioButton.check()
    await this.continueButton.click()
  }

  // Tag numbers are shown spaced, e.g. "UK 324537 100001"
  async verifyTagStatus(tagNumber: string, expectedStatus: string) {
    const row = this.animalsTable.getByRole('row').filter({
      has: this.page.getByRole('link', {
        name: tagNumber,
        exact: true
      })
    })

    // Columns are Tag number then Status
    await expect(row.getByRole('cell').nth(1)).toHaveText(expectedStatus)
  }

  // Also passes when the table isn't shown, e.g. after the last animal is cancelled
  async verifyTagNotListed(tagNumber: string) {
    await expect(
      this.animalsTable.getByRole('link', { name: tagNumber, exact: true })
    ).toHaveCount(0)
  }
}
