import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getEnv } from '../../../../../configs/env'
import { getHomeSelectors } from '../selectors/front-office/home.selectors'

export class LisFrontOfficeHomePage extends BasePage {
  public readonly speciesCards: Locator

  constructor(page: Page) {
    super(page)
    const env = getEnv()
    const selectors = getHomeSelectors(env)
    this.speciesCards = page.locator(selectors.speciesCards)
  }

  public async navigateToHomePage() {
    await this.goto('/')
  }

  public async clickStartNowLink() {
    await this.startNowLink.waitFor({ state: 'visible' })
    await this.startNowLink.scrollIntoViewIfNeeded()
    await this.startNowLink.click()
  }

  public async verifySignedIn() {
    await expect(this.signOutLink).toBeVisible()
  }

  public async selectSpecies(species: string) {
    const speciesOption = this.speciesCards.getByRole('link', { name: species })
    await speciesOption.waitFor({ state: 'visible' })
    await speciesOption.click()
  }

  public async verifyCphs(expectedCphs: string[][]) {
    const rows = await this.page.locator('.govuk-table tbody tr').all()
    for (const index in rows) {
      const expectedCph = expectedCphs[index]
      const columns = await rows[index].locator('td').all()
      for (const colIndex in columns) {
        await expect(expectedCph[colIndex]).toEqual(
          (await columns[colIndex].textContent())?.trim()
        )
      }
    }
  }

  public async verifyPageNotFound() {
    await expect(await this.heading.textContent()).toEqual('404')
    await expect(await this.page.getByText('Page not found')).toBeVisible()
  }
}
