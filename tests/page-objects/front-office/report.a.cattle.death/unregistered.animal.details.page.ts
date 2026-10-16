import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

type DateParts = {
  day: string
  month: string
  year: string
}

export class LisFrontOfficeUnregisteredAnimalDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator
  readonly maleRadio: Locator
  readonly femaleRadio: Locator
  readonly breedInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Animal details' })
    this.animalEarTagInput = page.getByRole('combobox', {
      name: 'Animal ear tag'
    })
    this.maleRadio = page.getByRole('radio', { name: 'Male', exact: true })
    this.femaleRadio = page.getByRole('radio', { name: 'Female' })
    this.breedInput = page.getByRole('combobox', { name: 'Breed' })
  }

  private async fillDate(prefix: 'death-dob' | 'death-date', date: DateParts) {
    await this.page.locator(`#${prefix}-day`).fill(date.day)
    await this.page.locator(`#${prefix}-month`).fill(date.month)
    await this.page.locator(`#${prefix}-year`).fill(date.year)
  }

  async submitAnimalDetails(
    earTag: string,
    dateOfBirth: DateParts,
    dateOfDeath: DateParts,
    gender: 'Male' | 'Female',
    breed: string
  ) {
    await this.animalEarTagInput.fill(earTag)
    await this.fillDate('death-dob', dateOfBirth)
    await this.fillDate('death-date', dateOfDeath)
    if (gender === 'Male') {
      await this.maleRadio.check()
    } else {
      await this.femaleRadio.check()
    }
    await this.breedInput.selectOption(breed)
    await this.continueButton.click()
  }
}
