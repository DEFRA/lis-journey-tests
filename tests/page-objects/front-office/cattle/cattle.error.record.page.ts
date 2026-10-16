import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class LisFrontOfficeCattleErrorRecordPage extends BasePage {
  readonly heading: Locator
  readonly bcmsEnquiriesEmailLink: Locator
  readonly findOutAboutCallChargesLink: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Cattle error record'
    })
    this.bcmsEnquiriesEmailLink = page.getByRole('link', {
      name: 'bcmsenquiries@rpa.gov.uk'
    })
    this.findOutAboutCallChargesLink = page.getByRole('link', {
      name: 'Find out about call charges'
    })
  }

  async clickTagNumberLink(reference: string) {
    const link = this.page.getByRole('link', { name: reference })
    await link.click()
  }

  async verifyTagStatus(tagNumber: string, expectedStatus: string) {
    const row = this.page.getByRole('row').filter({
      has: this.page.getByRole('link', {
        name: tagNumber,
        exact: true
      })
    })

    await expect(row.locator('.govuk-tag')).toHaveText(expectedStatus)
  }
}
