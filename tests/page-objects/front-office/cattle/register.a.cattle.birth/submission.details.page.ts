import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeSubmissionDetailsPage extends BasePage {
  readonly heading: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Submission   details' })
  }

  async verifySubmissionDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []

    for (const detail of expectedDetails) {
      for (const [key, expectedValue] of Object.entries(detail)) {
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

      const animalRow = animalsTable.locator('tbody tr').filter({
        has: animalsTable.getByRole('cell', {
          name: earTagNumber,
          exact: true
        })
      })

      for (const [header, expectedValue] of Object.entries(animal)) {
        const columnIndex = headers.indexOf(header)
        if (columnIndex === -1) {
          throw new Error(`No animals table column found for "${header}"`)
        }

        assertions.push(
          expect(animalRow.locator('td').nth(columnIndex)).toHaveText(
            expectedValue
          )
        )
      }
    }

    await Promise.all(assertions)
  }
}
