import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeRegisteredAnimalDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator
  readonly dayInput: Locator
  readonly monthInput: Locator
  readonly yearInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Animal details' })
    this.animalEarTagInput = page.getByRole('combobox', {
      name: 'Animal ear tag number'
    })
    this.dayInput = page.getByRole('textbox', { name: 'Day' })
    this.monthInput = page.getByRole('textbox', { name: 'Month' })
    this.yearInput = page.getByRole('textbox', { name: 'Year' })
  }

  async submitAnimalDetails(
    earTag: string,
    day: string,
    month: string,
    year: string
  ) {
    await this.animalEarTagInput.fill(earTag)
    await this.dayInput.fill(day)
    await this.monthInput.fill(month)
    await this.yearInput.fill(year)
    await this.continueButton.click()
  }
}
