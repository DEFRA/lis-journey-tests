import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeSubmissionDetailsPage extends BasePage {
  readonly heading: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Submission   details' })
  }

  async verifySubmissionDetails(expectedDetails: Record<string, string>) {
    const assertions: Promise<void>[] = []

    for (const [key, expectedValue] of Object.entries(expectedDetails)) {
      const detailRow = this.page.locator('.govuk-summary-list__row').filter({
        has: this.page
          .locator('.govuk-summary-list__key')
          .getByText(key, { exact: true })
      })
      assertions.push(
        expect(detailRow.locator('.govuk-summary-list__value')).toHaveText(
          expectedValue
        )
      )
    }

    await Promise.all(assertions)
  }

  async verifyRegisteredAnimals(expectedAnimals: Record<string, string>[]) {
    const animalsTable = this.page.locator('main .govuk-table').filter({
      has: this.page.getByRole('columnheader', {
        name: 'Ear tag number',
        exact: true
      })
    })
    const headers = (
      await animalsTable.locator('thead th').allTextContents()
    ).map((header) => header.trim())
    const assertions: Promise<void>[] = []

    for (const animal of expectedAnimals) {
      const earTagNumber = animal['Ear tag number']
      if (!earTagNumber) {
        throw new Error(
          'Expected animal details must include an Ear tag number'
        )
      }

      const animalRow = animalsTable
        .locator('tbody tr')
        .filter({ hasText: earTagNumber })

      for (const [header, expectedValue] of Object.entries(animal)) {
        const columnIndex = headers.indexOf(header)
        if (columnIndex === -1) {
          throw new Error(`No animals table column found for "${header}"`)
        }

        const cell = animalRow.locator('td').nth(columnIndex)
        const value = header === 'Breed' ? cell.locator('abbr') : cell
        assertions.push(expect(value).toHaveText(expectedValue))
      }
    }

    await Promise.all(assertions)
  }
}
