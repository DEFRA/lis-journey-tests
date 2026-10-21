import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeCancelThisRegistrationPage extends BasePage {
  readonly heading: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Are you sure you want to cancel this registration?'
    })
  }

  async confirmCancellation(Confirm: 'Continue' | 'Cancel') {
    if (Confirm === 'Continue') {
      await this.continueButton.click()
    } else {
      await this.cancelLink.click()
    }
  }
}
