import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeIsTheAnimalRegisteredPage extends BasePage {
  readonly heading: Locator
  readonly yesRadio: Locator
  readonly noRadio: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Is the animal registered?'
    })
    this.yesRadio = page.getByRole('radio', {
      name: 'Yes',
      exact: true
    })
    this.noRadio = page.getByRole('radio', {
      name: 'No',
      exact: true
    })
  }

  async submitAnimalRegistrationStatus(registrationStatus: 'Yes' | 'No') {
    if (registrationStatus === 'Yes') {
      await this.yesRadio.check()
    } else {
      await this.noRadio.check()
    }
    await this.continueButton.click()
  }
}
