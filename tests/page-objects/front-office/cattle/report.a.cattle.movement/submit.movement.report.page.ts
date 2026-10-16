import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeSubmitMovementReportPage extends BasePage {
  readonly heading: Locator
  readonly acceptAndSendButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Now submit your movement report'
    })
    this.acceptAndSendButton = page.getByRole('button', {
      name: 'Accept and send'
    })
  }
}
