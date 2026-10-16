import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeGeneticDamDetailsPage extends BasePage {
  readonly heading: Locator
  readonly animalEarTagInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Genetic dam details'
    })
    this.animalEarTagInput = page.getByRole('combobox', {
      name: 'Animal ear tag number',
      exact: true
    })
  }

  async submitAnimalEarTagNumber(animalEarTagNumber: string) {
    await this.animalEarTagInput.fill(animalEarTagNumber)
    await this.continueButton.click()
  }
}
