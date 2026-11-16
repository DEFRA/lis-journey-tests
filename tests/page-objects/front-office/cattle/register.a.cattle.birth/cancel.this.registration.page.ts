import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeCancelThisRegistrationPage extends BasePage {
  readonly heading: Locator
  readonly yesButton: Locator
  readonly noLink: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Are you sure you want to cancel this registration?'
    })
    this.yesButton = page.getByRole('button', { name: 'Yes' })
    this.noLink = page.getByRole('link', { name: 'No' })
  }

  // Yes cancels the registration, No goes back to it
  async confirmCancellation(confirm: 'Yes' | 'No') {
    const button = confirm === 'Yes' ? this.yesButton : this.noLink
    await button.click()
  }
}
