import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeCancelDraftRegistrationPage extends BasePage {
  readonly heading: Locator
  readonly cancelDraftButton: Locator
  readonly goBackLink: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Are you sure you want to cancel this draft registration?'
    })
    this.cancelDraftButton = page.getByRole('button', {
      name: 'Cancel draft'
    })
    this.goBackLink = page.getByRole('link', {
      name: 'Go back'
    })
  }
}
