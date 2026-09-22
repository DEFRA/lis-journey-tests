import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisBackOfficeHomePage extends BasePage {
  public readonly headingCaption: Locator

  constructor(page: Page) {
    super(page)
    this.headingCaption = page.locator('.govuk-caption-xl')
  }

  public async navigateToHomePage() {
    await this.goto('/')
  }

  public async verifySignedIn() {
    await expect(this.signOutLink).toBeVisible()
  }
}
