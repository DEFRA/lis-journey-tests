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
    const actualCphs = await Promise.all(
      rows.map((row) => row.locator('td').allTextContents())
    )

    for (const [rowIndex, actualColumns] of actualCphs.entries()) {
      for (const [columnIndex, actualCph] of actualColumns.entries()) {
        expect(expectedCphs[rowIndex][columnIndex]).toEqual(actualCph.trim())
      }
    }
  }
}
