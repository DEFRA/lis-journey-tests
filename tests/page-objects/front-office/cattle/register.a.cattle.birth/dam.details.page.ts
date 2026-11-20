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
      name: 'Calf born via genetic dam',
      exact: true
    })
    this.calfBornViaSurrogateDamRadio = page.getByRole('radio', {
      name: 'Calf born via surrogate dam'
    })
  }

  async submitDamDetails(
    damType: 'Calf born via genetic dam' | 'Calf born via surrogate dam'
  ) {
    if (damType === 'Calf born via genetic dam') {
      await this.calfBornViaGeneticDamRadio.check()
    } else {
      await this.calfBornViaSurrogateDamRadio.check()
    }
    await this.continueButton.click()
  }

  // Temporary hack: the page keeps the dam type from an earlier registration, and a radio
  // can't be unticked by clicking, so untick them in the browser. Remove when tests can
  // create their own test users/sessions instead of reusing the same user
  async clearDamDetails() {
    await Promise.all(
      [this.calfBornViaGeneticDamRadio, this.calfBornViaSurrogateDamRadio].map(
        (radio) =>
          radio.evaluate((input: HTMLInputElement) => {
            input.checked = false
          })
      )
    )
  }

  async verifyDamTypeSelected(damType: string) {
    if (damType === 'Calf born via genetic dam') {
      await expect(this.calfBornViaGeneticDamRadio).toBeChecked()
    } else if (damType === 'Calf born via surrogate dam') {
      await expect(this.calfBornViaSurrogateDamRadio).toBeChecked()
    } else {
      throw new Error(`Unexpected dam type: "${damType}"`)
    }
  }
}
