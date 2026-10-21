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
    this.animalEarTagInput = page
      .getByRole('combobox', {
        name: 'Animal ear tag number',
        exact: true
      })
      .filter({ visible: true })
  }

  async submitAnimalEarTagNumber(animalEarTagNumber: string) {
    await this.animalEarTagInput.waitFor({ state: 'visible' })
    await this.animalEarTagInput.fill(animalEarTagNumber)
    const suggestion = this.page.getByRole('option', {
      name: animalEarTagNumber,
      exact: true
    })
    await suggestion.waitFor({ state: 'visible' })
    await suggestion.click()
    await this.continueButton.click()
  }
}
