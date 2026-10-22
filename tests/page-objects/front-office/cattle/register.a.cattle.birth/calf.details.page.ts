import { Locator, Page, expect } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeRegisterCalfDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator
  readonly dateInput: Locator
  readonly maleRadio: Locator
  readonly femaleRadio: Locator
  readonly breedInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Calf details' })
    this.animalEarTagInput = page
      .getByRole('combobox', {
        name: 'Animal ear tag number',
        exact: true
      })
      .filter({ visible: true })
    this.dateInput = page.getByRole('textbox', { name: 'Date of birth' })
    this.maleRadio = page.getByRole('radio', { name: 'Male', exact: true })
    this.femaleRadio = page.getByRole('radio', { name: 'Female' })
    this.breedInput = page.getByRole('combobox', { name: 'Breed' })
  }

  async submitCalfDetails(
    earTag: string,
    day: string,
    month: string,
    year: string,
    sexOfCalf: 'Male' | 'Female',
    breed: string
  ) {
    await this.selectAutocompleteOption(this.animalEarTagInput, earTag)
    await this.dateInput.fill(day + '/' + month + '/' + year)
    await this.selectSexOfCalf(sexOfCalf)
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
