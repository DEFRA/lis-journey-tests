import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeMyProfilePage extends BasePage {
  readonly heading: Locator
  readonly nameField: Locator
  readonly emailAddressField: Locator
  readonly phoneNumberField: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'My profile' })
    this.nameField = page.getByText('Name', { exact: true }).locator('..')
    this.emailAddressField = page
      .getByText('Email address', { exact: true })
      .locator('..')
    this.phoneNumberField = page
      .getByText('Phone number', { exact: true })
      .locator('..')
  }
}
