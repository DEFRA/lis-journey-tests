import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeDamDetailsPage extends BasePage {
  readonly heading: Locator
  readonly calfBornViaGeneticDamRadio: Locator
  readonly calfBornViaSurrogateDamRadio: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Dam details'
    })
    this.calfBornViaGeneticDamRadio = page.getByRole('radio', {
      name: 'calf born via genetic dam',
      exact: true
    })
    this.calfBornViaSurrogateDamRadio = page.getByRole('radio', {
      name: 'calf born via surrogate dam'
    })
  }

  async submitDamDetails(
    damType: 'calf born via genetic dam' | 'calf born via surrogate dam'
  ) {
    if (damType === 'calf born via genetic dam') {
      await this.calfBornViaGeneticDamRadio.check()
    } else {
      await this.calfBornViaSurrogateDamRadio.check()
    }
    await this.continueButton.click()
  }

  async verifyDamTypeSelected(damType: string) {
    const damTypeRadio =
      damType === 'calf born via genetic dam'
        ? this.calfBornViaGeneticDamRadio
        : damType === 'calf born via surrogate dam'
          ? this.calfBornViaSurrogateDamRadio
          : undefined

    if (!damTypeRadio) {
      throw new Error(`Unexpected dam type: "${damType}"`)
    }

    await expect(damTypeRadio).toBeChecked()
  }
}
