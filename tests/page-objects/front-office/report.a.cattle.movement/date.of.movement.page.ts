import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeDateOfMovementPage extends BasePage {
  readonly heading: Locator
  readonly dayInput: Locator
  readonly monthInput: Locator
  readonly yearInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'What is the date of the movement?'
    })
    this.dayInput = page.getByRole('textbox', { name: 'Day' })
    this.monthInput = page.getByRole('textbox', { name: 'Month' })
    this.yearInput = page.getByRole('textbox', { name: 'Year' })
  }

  async submitMovementDates(day: string, month: string, year: string) {
    await this.dayInput.fill(day)
    await this.monthInput.fill(month)
    await this.yearInput.fill(year)
    await this.continueButton.click()
  }
}
