import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisBackOfficeHomePage extends BasePage {
  readonly headingCaption: Locator

  constructor(page: Page) {
    super(page)
    this.headingCaption = page.locator('.govuk-caption-xl')
  }

  async navigateToHomePage() {
    const backOfficeUrl = process.env.backOfficeUrl
    if (!backOfficeUrl) {
      throw new Error('backOfficeUrl has not been configured')
    }
    await this.goto(backOfficeUrl)
  }

  async verifySignedIn() {
    await expect(this.signOutLink).toBeVisible()
  }
}
