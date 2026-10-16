import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeSubmitCattleRegistrationPage extends BasePage {
  readonly heading: Locator
  readonly acceptAndSendButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Now submit your cattle registration'
    })
    this.acceptAndSendButton = page.getByRole('button', {
      name: 'Accept and send'
    })
  }
}
