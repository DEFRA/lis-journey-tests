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
    await this.selectAutocompleteOption(
      this.animalEarTagInput,
      animalEarTagNumber
    )
    await this.continueButton.click()
  }

  // The page keeps the dam ear tag from an earlier registration, so it is cleared
  async clearGeneticDamDetails() {
    await this.animalEarTagInput.clear()
  }
}
