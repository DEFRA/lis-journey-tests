import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeCheckMovementDetailsPage extends BasePage {
  readonly heading: Locator
  readonly cancelBirthRegistrationButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Check movement details' })
    this.cancelBirthRegistrationButton = page.getByRole('button', {
      name: 'Cancel birth registration'
    })
  }

  // Each animal is a summary card titled e.g. "Animal 1"
  animalCard(animal: string) {
    return this.page.locator('.govuk-summary-card').filter({
      has: this.page
        .locator('.govuk-summary-card__title')
        .getByText(animal, { exact: true })
    })
  }

  // The date row is "On movement date" or "Off movement date", so it's matched by its ending
  animalRow(animal: string, field: 'ear tag number' | 'movement date') {
    const key =
      field === 'ear tag number' ? /^Ear tag number$/ : /movement date$/
    return this.animalCard(animal)
      .locator('.govuk-summary-list__row')
      .filter({
        has: this.page.locator('.govuk-summary-list__key').getByText(key)
      })
  }

  async verifyAnimalDetail(
    animal: string,
    field: 'ear tag number' | 'movement date',
    expectedValue: string
  ) {
    await expect(
      this.animalRow(animal, field).locator('.govuk-summary-list__value')
    ).toHaveText(expectedValue)
  }

  // An animal, e.g. "Animal 1", is changed from its ear tag row
  async clickChangeLink(sectionName: string) {
    const sectionRow = /^Animal \d+$/.test(sectionName)
      ? this.animalRow(sectionName, 'ear tag number')
      : this.page.locator('.govuk-summary-list__row').filter({
          has: this.page.locator('dt').getByText(sectionName, { exact: true })
        })

    await sectionRow.getByRole('link', { name: /^Change/ }).click()
  }
}
