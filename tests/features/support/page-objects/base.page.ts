import { Locator, Page, expect } from '@playwright/test'

export class BasePage {
  public page: Page
  public readonly heading: Locator
  public readonly body: Locator
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
    this.body = page.locator('.govuk-body')
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

  async formatDateYearMonth(startDate: string) {
    const result = await this.calculateTimeDifference(startDate)
    let yearString = `${result.years} year${result.years > 1 ? 's' : ''}`
    let monthString = `${result.months} month${result.months > 1 ? 's' : ''}`
    if (result.years === 0) {
      yearString = `0 years`
    }
    if (result.months === 0) {
      monthString = '0 months'
    }
    return `${yearString}, ${monthString}`
  }

  async calculateTimeDifference(startDateStr: string) {
    const start = new Date(startDateStr)
    const end = new Date()

    let years = end.getFullYear() - start.getFullYear()
    let months = end.getMonth() - start.getMonth()
    let days = end.getDate() - start.getDate()

    // Adjust for negative days (if the end day is earlier in the month than the start day)
    if (days < 0) {
      months -= 1
      // Get the total days in the previous month of the end date
      const previousMonth = new Date(end.getFullYear(), end.getMonth(), 0)
      days += previousMonth.getDate()
    }

    // Adjust for negative months
    if (months < 0) {
      years -= 1
      months += 12
    }

    // Calculate total combined months
    const totalMonths = years * 12 + months

    return {
      totalMonths: totalMonths,
      remainingDays: days,
      years: years,
      months: months
    }
  }
}
