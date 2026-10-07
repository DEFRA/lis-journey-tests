import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getEnv } from '../../../../../configs/env'
import { getAnimalsOnHoldingSelectors } from '../selectors/front-office/animals.on.holding.selectors'

export class LisFrontOfficeAnimalsOnHoldingPage extends BasePage {
  public readonly heading: Locator
  public readonly navigationTab: Locator
  public readonly searchLabel: Locator
  public readonly searchHint: Locator
  public readonly searchInput: Locator
  public readonly searchInsetInfo: Locator
  public readonly nextPaginationLink: Locator
  public readonly previousPaginationLink: Locator
  public readonly searchButton: Locator

  constructor(page: Page) {
    super(page)
    const env = getEnv()
    const selectors = getAnimalsOnHoldingSelectors(env)
    this.navigationTab = page.locator(selectors.navigationTab)
    this.heading = page.locator('.govuk-heading-l')
    this.searchLabel = page.locator(selectors.searchLabel)
    this.searchHint = page.locator(selectors.searchHint)
    this.searchInput = page.locator(selectors.searchInput)
    this.searchInsetInfo = page.locator(selectors.searchInsetInfo)
    this.nextPaginationLink = page.locator(selectors.nextPaginationLink)
    this.previousPaginationLink = page.locator(selectors.previousPaginationLink)
    this.searchButton = page.locator(selectors.searchButton)
  }

  public async verifySearchCapabilities() {
    await expect(this.searchLabel).toHaveText('Search animals on your holding')
    await expect(this.searchHint).toHaveText(
      'You can use all or part of the animal ear tag number, or search by sex or breed.'
    )
    await expect(this.searchInput).toBeVisible()
    await expect(this.searchInsetInfo).toHaveText(
      'Recent changes such as new registrations may take up to 24 hours to appear in your list.'
    )
  }

  public async verifyAnimalsOnHolding(
    expectedAnimalsOnHolding: Record<string, string>[]
  ) {
    await this.verifyAnimalsOnHoldingHeaders(
      Object.keys(expectedAnimalsOnHolding[0])
    )
    let itemCounter = 0
    let pageNumber = 1
    let paginationStart = 1
    let offSet = 25
    const totalNumberOfItems = expectedAnimalsOnHolding.length

    await this.verifyPaginationInformation(
      paginationStart,
      offSet,
      expectedAnimalsOnHolding.length
    )
    for (const animalsOnHoldingIndex in expectedAnimalsOnHolding) {
      if (itemCounter === 25) {
        await this.nextPaginationLink.scrollIntoViewIfNeeded()
        await this.nextPaginationLink.click()
        this.page.pause()

        itemCounter = 0 // reset item counter
        pageNumber = pageNumber + 1
        await this.page.waitForURL(
          `**sort=ear_tag&direction=asc&page=${pageNumber}`
        )
        paginationStart = parseInt(animalsOnHoldingIndex) + 1
        offSet =
          totalNumberOfItems - parseInt(animalsOnHoldingIndex) < 25
            ? expectedAnimalsOnHolding.length
            : parseInt(animalsOnHoldingIndex) + 25
        await this.verifyPaginationInformation(
          paginationStart,
          offSet,
          totalNumberOfItems
        )
      }
      const rows = await this.page.locator('table tbody tr').all()
      await this.verifyNextAndPreviousLinkBehavior(paginationStart, rows.length)
      const row = await rows[itemCounter]
      await row.scrollIntoViewIfNeeded()
      const columns = await row.locator('td').all()
      for (const columnIndex in columns) {
        const values = Object.values(
          expectedAnimalsOnHolding[animalsOnHoldingIndex]
        )
        if (values[columnIndex].includes('formatDateYearMonth')) {
          const birthDate = values[columnIndex].split(':')[1]
          const birthDateYearMonth = await this.formatDateYearMonth(birthDate)
          await expect(birthDateYearMonth).toEqual(
            (await columns[columnIndex].textContent())?.trim()
          )
        } else {
          await expect(values[columnIndex]).toEqual(
            (await columns[columnIndex].textContent())?.trim()
          )
        }
      }
      itemCounter = itemCounter + 1 // increment item counter to the next item
    }
  }

  public async verifyAnimalsOnHoldingHeaders(expectedHeaders: string[]) {
    const tableHeaders = await this.page.locator('table thead tr th').all()
    for (const index in expectedHeaders) {
      const tableHeader = (await tableHeaders[index].textContent())?.trim()
      const expectedHeader = expectedHeaders[index]
      expect(expectedHeader).toEqual(tableHeader)
    }
  }

  public async verifyPaginationInformation(
    start: number,
    offSet: number,
    totalNoOfItems: number
  ) {
    let expectedString = `Showing ${start} to ${offSet} of ${totalNoOfItems} result${totalNoOfItems > 1 ? 's' : ''}`
    if (totalNoOfItems < 25) {
      expectedString = `Showing ${totalNoOfItems} result${totalNoOfItems > 1 ? 's' : ''}`
    }
    const paginationInfo = await this.page.getByText(expectedString)
    await paginationInfo.scrollIntoViewIfNeeded()
    await expect(paginationInfo).toBeVisible()
  }

  public async verifyNextAndPreviousLinkBehavior(
    startCounter: number,
    rowCount: number
  ) {
    if (rowCount < 25) {
      await expect(this.nextPaginationLink).not.toBeVisible()
    } else {
      await expect(this.nextPaginationLink).toBeVisible()
      if (startCounter === 1) {
        await expect(this.previousPaginationLink).not.toBeVisible()
      } else {
        await expect(this.previousPaginationLink).toBeVisible()
      }
    }
  }

  public async searchUsing(searchTerm: string) {
    await this.searchInput.fill(searchTerm)
    await this.searchButton.click()
  }

  public async verifyAnimalsOnHoldingSearchResult(
    searchTerm: string,
    expectedSearchResults: Record<string, string>[]
  ) {
    const expectedSarchResulHint = `${expectedSearchResults.length} result${expectedSearchResults.length > 1 ? 's' : ''} for '${searchTerm}'`
    await expect(
      await this.page.getByText(expectedSarchResulHint)
    ).toBeVisible()
    await expect(
      await this.page.getByRole('link', { name: 'Clear search' })
    ).toBeVisible()
    await this.verifyAnimalsOnHolding(expectedSearchResults)
  }

  public async verifyNoResultsForSearchTerm(searchTerm: string) {
    const expectedSarchResulHint = `0 results for '${searchTerm}'`
    await expect(
      await this.page.getByText(expectedSarchResulHint)
    ).toBeVisible()
  }
}
