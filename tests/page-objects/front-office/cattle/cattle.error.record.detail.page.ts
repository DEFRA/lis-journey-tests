import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeCattleErrorRecordDetailPage extends BasePage {
  readonly heading: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.locator('main h1')
  }

  async verifyErrorRecordDetails(expectedDetails: Record<string, string>[]) {
    const assertions: Promise<void>[] = []
    const expectedEntries = expectedDetails.flatMap((detail) =>
      Object.entries(detail)
    )
    const expectedReference = expectedEntries.find(
      ([key]) => key === 'Animal reference'
    )?.[1]
    const expectedSummaryRowCount = expectedEntries.filter(
      ([key]) => key !== 'Animal reference'
    ).length

    if (expectedReference === undefined) {
      throw new Error('Expected details must include Animal reference')
    }

    assertions.push(
      expect(this.heading).toHaveText(expectedReference, {
        useInnerText: true
      })
    )
    assertions.push(
      expect(this.page.locator('.govuk-summary-list__row')).toHaveCount(
        expectedSummaryRowCount
      )
    )

    for (const [key, expectedValue] of expectedEntries) {
      if (key === 'Animal reference') {
        continue
      }

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
}
