import { Locator, Page, expect } from '@playwright/test'

export class BasePage {
  public page: Page
  public readonly heading: Locator
  public readonly subHeading: Locator
  public readonly headingCaption: Locator
  public readonly backButton: Locator
  public readonly errorTitle: Locator
  public readonly errorMessages: Locator
  public readonly alert: Locator
  public readonly alertHeading: Locator
  public readonly alertMessage: Locator
  public readonly signOutLink: Locator
  public readonly menuBar: Locator
  public readonly startNowLink: Locator
  public readonly profileMenuLink: Locator
  public readonly cattleMenuLink: Locator

  constructor(page: Page) {
    this.page = page
    this.heading = page.locator('.govuk-heading-xl')
    this.subHeading = page.locator('.govuk-heading-l')
    this.headingCaption = page.locator('.govuk-caption-l')
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
    this.menuBar = page.getByLabel('Menu')
    this.signOutLink = this.menuBar.getByRole('link', { name: 'Sign out' })
    this.startNowLink = page.getByRole('button', { name: 'Start now' })
    this.profileMenuLink = this.menuBar.getByRole('link', { name: 'Profile' })
    this.cattleMenuLink = this.menuBar.getByRole('link', { name: 'Cattle' })
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

  async navigateToHoldingDetails(species: string, cphNumber: string) {
    await this.page.goto(`/${species}/holdings/${cphNumber}`)
  }
}
