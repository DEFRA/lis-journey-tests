import { expect } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHomePage extends BasePage {
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
    const speciesOption = this.page.getByRole('link', { name: species })
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
