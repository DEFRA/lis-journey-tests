import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeSurrogateDamDetailsPage extends BasePage {
  readonly heading: Locator
  readonly geneticDamEarTagInput: Locator
  readonly surrogateDamEarTagInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Genetic and Surrogate dam details'
    })
    this.geneticDamEarTagInput = page.getByRole('textbox', {
      name: 'Genetic dam ear tag number'
    })
    this.surrogateDamEarTagInput = page.getByRole('combobox', {
      name: 'Surrogate dam ear tag number',
      exact: true
    })
  }

  async submitGeneticAndSurrogateDamEarTagNumbers(
    geneticDamEarTagNumber: string
  ) {
    await this.geneticDamEarTagInput.fill(geneticDamEarTagNumber)
    await this.surrogateDamEarTagInput.selectOption('Surrogate Dam 1')
    await this.continueButton.click()
  }
}
