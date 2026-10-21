import { Locator, Page, expect } from '@playwright/test'

export class BasePage {
  page: Page
  readonly heading: Locator
  readonly body: Locator
  readonly subHeading: Locator
  readonly headingCaption: Locator
  readonly backButton: Locator
  readonly errorTitle: Locator
  readonly errorMessages: Locator
  readonly alert: Locator
  readonly alertHeading: Locator
  readonly alertMessage: Locator
  readonly signOutLink: Locator
  readonly menuBar: Locator
  readonly startNowLink: Locator
  readonly profileMenuLink: Locator
  readonly cattleMenuLink: Locator
  readonly myProfileLink: Locator
  readonly continueButton: Locator
  readonly cancelLink: Locator

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
    this.myProfileLink = page.getByRole('link', { name: 'My profile' })
    this.continueButton = page.getByRole('button', { name: 'Continue' })
    this.cancelLink = page.getByRole('link', { name: 'Cancel' })
  }

  async goto(path: string) {
    await this.page.goto(path)
  }

  async getTitle() {
    return await this.page.title()
  }

  async verifyError(messages: string[]) {
    await Promise.all(
      messages.map((message) =>
        expect(this.errorMessages).toContainText(message)
      )
    )
  }

  async validateSummaryErrors(expectedErrors: string[]) {
    await expect(this.errorTitle).toHaveText('There is a problem')
    await expect(
      this.page.locator('.govuk-error-summary .govuk-error-summary__list a')
    ).toHaveText(expectedErrors)
  }

  async validateFieldErrors(expectedErrors: string[]) {
    const fieldErrors = this.page.locator('.govuk-error-message')

    await expect
      .poll(async () =>
        (await fieldErrors.allTextContents()).map((message) =>
          message.replace(/^\s*Error:\s*/, '').trim()
        )
      )
      .toEqual(expectedErrors)
  }

  async verifyFieldAndSummaryErrors(expectedErrors: string[]) {
    await Promise.all([
      this.validateSummaryErrors(expectedErrors),
      this.validateFieldErrors(expectedErrors)
    ])
  }

  async navigateToHoldingDetails(species: string, cphNumber: string) {
    await this.page.goto(`/${species}/holdings/${cphNumber}`)
  }

  formatDateYearMonth(startDate: string) {
    const result = this.calculateTimeDifference(startDate)
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

  calculateTimeDifference(startDateStr: string) {
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
