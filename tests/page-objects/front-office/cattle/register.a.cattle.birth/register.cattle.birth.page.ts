import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

export class LisFrontOfficeRegisterCattleBirthPage extends BasePage {
  readonly heading: Locator
  readonly startBirthRegistrationButton: Locator
  readonly draftDateStartedField: Locator
  readonly draftTotalBirthsField: Locator
  readonly registrationHistoryResultsField: Locator
  readonly cancelLink: Locator
  readonly continueLink: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Register a cattle birth'
    })
    this.startBirthRegistrationButton = page.getByRole('button', {
      name: 'Start birth registration'
    })
    this.draftDateStartedField = page
      .getByText('Date started', { exact: true })
      .locator('..')
    this.draftTotalBirthsField = page
      .getByText('Total births', { exact: true })
      .locator('..')
    this.registrationHistoryResultsField = page.getByText('Showing')
    this.cancelLink = page.getByRole('link', { name: 'Cancel' })
    this.continueLink = page.getByRole('link', { name: 'Continue' })
  }

  async clickRegistrationHistoryReferenceLink(reference: string) {
    const link = this.page.getByRole('link', { name: reference })
    await link.click()
  }

  async verifyRegistrationStatus(reference: string, expectedStatus: string) {
    const registrationRow = this.page.getByRole('row').filter({
      has: this.page.getByRole('link', { name: reference, exact: true })
    })

    await expect(registrationRow.locator('.govuk-tag')).toHaveText(
      expectedStatus
    )
  }
}
