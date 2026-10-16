import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeCattleHoldingOverviewPage extends BasePage {
  readonly heading: Locator
  readonly overviewTab: Locator
  readonly holdingDetailsTab: Locator
  readonly cattleOnHoldingAmount: Locator
  readonly cattleOnHoldingLink: Locator
  readonly pendingValidationAmount: Locator
  readonly pendingValidationLink: Locator
  readonly cattleErrorsAmount: Locator
  readonly cattleErrorsLink: Locator
  readonly registerCattleBirthLink: Locator
  readonly reportCattleMovementLink: Locator
  readonly reportCattleDeathLink: Locator
  readonly downloadListOfCattleOnYourHoldingLink: Locator
  readonly govUkGuidanceForCattleLink: Locator
  readonly contactBcmsLink: Locator

  constructor(page: Page) {
    super(page)
    this.overviewTab = page.getByRole('link', { name: 'Overview' })
    this.holdingDetailsTab = page.getByRole('link', { name: 'Holding details' })
    this.heading = page.getByRole('heading', { name: 'Cattle' })
    this.cattleOnHoldingAmount = page
      .locator('.app-traffic-card__number')
      .nth(0)
    this.cattleOnHoldingLink = page.getByRole('link', {
      name: 'Cattle on holding'
    })
    this.pendingValidationAmount = page
      .locator('app-traffic-card__number')
      .nth(1)
    this.pendingValidationLink = page.getByRole('link', {
      name: 'Pending validation'
    })
    this.cattleErrorsAmount = page.locator('.app-traffic-card__number').nth(2)
    this.cattleErrorsLink = page.getByRole('link', {
      name: 'Cattle errors'
    })
    this.registerCattleBirthLink = page.getByRole('link', {
      name: 'Register a cattle birth'
    })
    this.reportCattleMovementLink = page.getByRole('link', {
      name: 'Report a cattle movement'
    })
    this.reportCattleDeathLink = page.getByRole('link', {
      name: 'Report a cattle death'
    })
    this.downloadListOfCattleOnYourHoldingLink = page.getByRole('link', {
      name: 'Download a list of cattle on'
    })
    this.govUkGuidanceForCattleLink = page.getByRole('link', {
      name: 'GOV.UK guidance for cattle'
    })
    this.contactBcmsLink = page.getByRole('link', { name: 'Contact BCMS' })
  }
}
