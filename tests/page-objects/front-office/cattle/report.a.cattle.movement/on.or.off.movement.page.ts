import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeOnOrOffMovementPage extends BasePage {
  readonly heading: Locator
  readonly onMovementRadio: Locator
  readonly offMovementRadio: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Is this an on or off movement?'
    })
    this.onMovementRadio = page.getByRole('radio', {
      name: 'On movement',
      exact: true
    })
    this.offMovementRadio = page.getByRole('radio', {
      name: 'Off movement',
      exact: true
    })
  }

  async submitMovementDetails(movementType: 'On movement' | 'Off movement') {
    if (movementType === 'On movement') {
      await this.onMovementRadio.check()
    } else {
      await this.offMovementRadio.check()
    }
    await this.continueButton.click()
  }
}
