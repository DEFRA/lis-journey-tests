import { Locator, Page, expect } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeAnimalDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator
  readonly dobInput: Locator
  readonly dodInput: Locator
  readonly maleRadio: Locator
  readonly femaleRadio: Locator
  readonly breedInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Animal details' })
    this.animalEarTagInput = page.getByRole('combobox', {
      name: 'Animal ear tag number'
    })
    this.dobInput = page.getByRole('textbox', { name: 'Date of birth' })
    this.dodInput = page.getByRole('textbox', { name: 'Date of death' })
    this.maleRadio = page.getByRole('radio', { name: 'Male', exact: true })
    this.femaleRadio = page.getByRole('radio', { name: 'Female' })
    this.breedInput = page.getByRole('combobox', { name: 'Breed' })
  }

  async submitRegisteredAnimalDetails(earTag: string, dateOfDeath: string) {
    await this.animalEarTagInput.fill(earTag)
    await this.dodInput.fill(dateOfDeath)
    await this.continueButton.click()
  }

  async submitUnregisteredAnimalDetails(
    earTag: string,
    dateOfBirth: string,
    dateOfDeath: string,
    sexOfAnimal: 'Male' | 'Female',
    breed: string
  ) {
    await this.selectAutocompleteOption(this.animalEarTagInput, earTag)
    await this.dobInput.fill(dateOfBirth)
    await this.dodInput.fill(dateOfDeath)
    await this.selectSexOfCalf(sexOfAnimal)
    await this.selectAutocompleteOption(this.breedInput, breed)
    await this.continueButton.click()
  }

  async selectAutocompleteOption(input: Locator, option: string) {
    await expect(input).toBeVisible()
    await input.fill(option)
    const suggestion = this.page.getByRole('option', {
      name: option,
      exact: true
    })
    await suggestion.waitFor({ state: 'visible' })
    await suggestion.click()
  }

  async selectSexOfCalf(sexOfCalf: string) {
    if (sexOfCalf === 'Male') {
      await this.maleRadio.check()
    } else {
      await this.femaleRadio.check()
    }
  }
}
