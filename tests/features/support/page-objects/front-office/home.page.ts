import { expect, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHomePage extends BasePage {
  constructor(page: Page) {
    super(page)
  }

  public async navigateToHomePage() {
    await this.goto('/')
  }

  public async clickStartNowLink() {
    await this.startNowLink.waitFor({ state: 'visible' })
    await this.startNowLink.scrollIntoViewIfNeeded()
    await this.startNowLink.click()
  }

  public async verifySignedIn() {
    await expect(this.signOutLink).toBeVisible()
  }
}
