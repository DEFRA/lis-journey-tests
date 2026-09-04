import { Locator, Page, expect } from '@playwright/test'

export class BasePage {
  public page: Page
  public readonly heading: Locator
  public readonly headingCaption: Locator
  public readonly backButton: Locator
  public readonly errorTitle: Locator
  public readonly errorMessages: Locator
  public readonly alert: Locator
  public readonly alertHeading: Locator
  public readonly alertMessage: Locator
  public readonly signOutLink: Locator

  constructor(page: Page) {
    this.page = page
    this.heading = page.locator('.govuk-heading-xl')
    this.headingCaption = page.locator('.govuk-caption-xl')
    this.backButton = page.locator('.govuk-back-link')
    this.errorTitle = page.locator(
      '.govuk-error-summary .govuk-error-summary__title'
    )
    this.errorMessages = page.locator(
      '.govuk-error-summary .govuk-error-summary__body ul li'
    )
    this.alert = page.locator('div[role=alert]')
    this.alertHeading = page.locator('.govuk-notification-banner__heading')
    this.alertMessage = page.locator('p.govuk-body')
    this.signOutLink = page
      .getByLabel('Menu')
      .getByRole('link', { name: 'Sign out' })
  }

  async goto(path: string) {
    await this.page.goto(path)
  }

  async getTitle() {
    return await this.page.title()
  }

  async verifyError(messages: string[]) {
    for (const message of messages) {
      await expect(this.errorMessages).toContainText(message)
    }
  }
}
