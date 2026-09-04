import { expect, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisBackOfficeHomePage extends BasePage {
  constructor(page: Page) {
    super(page)
  }

  public async navigateToHomePage() {
    await this.goto('/')
  }

  public async verifySignedIn() {
    await expect(this.signOutLink).toBeVisible()
  }
}
