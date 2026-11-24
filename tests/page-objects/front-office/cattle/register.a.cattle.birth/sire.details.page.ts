import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeSireDetailsPage extends BasePage {
  readonly heading: Locator
  readonly sireEarTagNumberInput: Locator
  readonly sireNameInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Sire details'
    })
    this.sireEarTagNumberInput = page.getByRole('textbox', {
      name: 'Sire ear tag number (optional)'
    })
    this.sireNameInput = page.getByRole('textbox', {
      name: 'Sire name (optional)'
    })
  }

  // A field left out keeps its current value, e.g. to change only the ear tag
  async submitSireDetails(sireEarTagNumber?: string, sireName?: string) {
    if (sireEarTagNumber !== undefined) {
      await this.sireEarTagNumberInput.fill(sireEarTagNumber)
    }
    if (sireName !== undefined) {
      await this.sireNameInput.fill(sireName)
    }
    await this.continueButton.click()
  }

  // The page keeps the sire details from an earlier registration,
  // so both fields are cleared rather than just left alone
  async submitNoSireDetails() {
    await this.sireEarTagNumberInput.clear()
    await this.sireNameInput.clear()
    await this.continueButton.click()
  }
}
