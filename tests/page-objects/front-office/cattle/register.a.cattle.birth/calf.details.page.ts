import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeRegisterCalfDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator
  readonly dayInput: Locator
  readonly monthInput: Locator
  readonly yearInput: Locator
  readonly maleRadio: Locator
  readonly femaleRadio: Locator
  readonly breedInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Calf details' })
    this.animalEarTagInput = page.getByRole('combobox', {
      name: 'Animal ear tag'
    })
    this.dayInput = page.getByRole('textbox', { name: 'Day' })
    this.monthInput = page.getByRole('textbox', { name: 'Month' })
    this.yearInput = page.getByRole('textbox', { name: 'Year' })
    this.maleRadio = page.getByRole('radio', { name: 'Male', exact: true })
    this.femaleRadio = page.getByRole('radio', { name: 'Female' })
    this.breedInput = page.getByRole('combobox', { name: 'Breed' })
  }

  async submitCalfDetails(
    earTag: string,
    day: string,
    month: string,
    year: string,
    gender: 'Male' | 'Female',
    breed: string
  ) {
    await this.animalEarTagInput.fill(earTag)
    await this.dayInput.fill(day)
    await this.monthInput.fill(month)
    await this.yearInput.fill(year)
    if (gender === 'Male') {
      await this.maleRadio.check()
    } else {
      await this.femaleRadio.check()
    }
    await this.breedInput.selectOption(breed)
    await this.continueButton.click()
  }
}
