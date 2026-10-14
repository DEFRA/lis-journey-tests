import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { parseExpectedAnimalValue } from '../../utils/expected-animal-value'

type PaginationState = {
  itemCounter: number
  pageNumber: number
  paginationStart: number
  offset: number
}

export class LisFrontOfficeAnimalsOnHoldingPage extends BasePage {
  public readonly heading: Locator
  public readonly searchLabel: Locator
  public readonly searchHint: Locator
  public readonly searchInput: Locator
  public readonly searchInsetInfo: Locator
  public readonly nextPaginationLink: Locator
  public readonly previousPaginationLink: Locator
  public readonly searchButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', {
      name: 'Animals on holding',
      exact: true
    })
    this.searchLabel = page.getByText('Search animals on your holding', {
      exact: true
    })
    this.searchHint = page.getByText(
      'You can use all or part of the animal ear tag number, or search by sex or breed.',
      { exact: true }
    )
    this.searchInput = page.getByRole('searchbox', {
      name: 'Search animals on your holding'
    })
    this.searchInsetInfo = page.getByText(
      'Recent changes such as new registrations may take up to 24 hours to appear in your list.',
      { exact: true }
    )
    this.nextPaginationLink = page.getByRole('link', { name: 'Next page' })
    this.previousPaginationLink = page.getByRole('link', {
      name: 'Previous page'
    })
    this.searchButton = page.getByRole('button', {
      name: 'Search',
      exact: true
    })
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
    if (expectedAnimalsOnHolding.length === 0) {
      throw new Error('Expected animals on holding list cannot be empty')
    }

    await this.verifyAnimalsOnHoldingHeaders(
      Object.keys(expectedAnimalsOnHolding[0])
    )

    const paginationState = {
      itemCounter: 0,
      pageNumber: 1,
      paginationStart: 1,
      offset: Math.min(25, expectedAnimalsOnHolding.length)
    }
    const totalNumberOfItems = expectedAnimalsOnHolding.length

    await this.verifyPaginationInformation(
      paginationState.paginationStart,
      paginationState.offset,
      totalNumberOfItems
    )

    await expectedAnimalsOnHolding.reduce(
      (verification, expectedAnimal, animalIndex) =>
        verification.then(async () => {
          await this.moveToNextPageIfNeeded(
            animalIndex,
            paginationState,
            totalNumberOfItems
          )
          await this.verifyAnimalRow(
            expectedAnimal,
            paginationState,
            totalNumberOfItems
          )
        }),
      Promise.resolve()
    )
  }

  private async moveToNextPageIfNeeded(
    animalIndex: number,
    paginationState: PaginationState,
    totalNumberOfItems: number
  ) {
    if (paginationState.itemCounter !== 25) {
      return
    }

    await this.nextPaginationLink.scrollIntoViewIfNeeded()
    await this.nextPaginationLink.click()

    paginationState.itemCounter = 0
    paginationState.pageNumber += 1
    await this.page.waitForURL(
      `**sort=ear_tag&direction=asc&page=${paginationState.pageNumber}`
    )
    paginationState.paginationStart = animalIndex + 1
    paginationState.offset = Math.min(
      paginationState.paginationStart + 24,
      totalNumberOfItems
    )
    await this.verifyPaginationInformation(
      paginationState.paginationStart,
      paginationState.offset,
      totalNumberOfItems
    )
  }

  private async verifyAnimalRow(
    expectedAnimal: Record<string, string>,
    paginationState: PaginationState,
    totalNumberOfItems: number
  ) {
    const rows = await this.page.locator('table tbody tr').all()
    await this.verifyNextAndPreviousLinkBehavior(
      paginationState.paginationStart,
      rows.length,
      totalNumberOfItems
    )

    const row = rows[paginationState.itemCounter]
    if (!row) {
      throw new Error(
        `Expected animal row ${paginationState.itemCounter + 1} on the page`
      )
    }

    await row.scrollIntoViewIfNeeded()
    const columns = await row.locator('td').all()
    const values = Object.values(expectedAnimal)
    expect(columns).toHaveLength(values.length)

    await Promise.all(
      columns.map(async (column, columnIndex) => {
        const expectedValue = values[columnIndex]
        if (expectedValue === undefined) {
          throw new Error(
            `Expected value missing for animal column ${columnIndex + 1}`
          )
        }

        await this.verifyAnimalColumnValue(column, expectedValue)
      })
    )

    paginationState.itemCounter += 1
  }

  private async verifyAnimalColumnValue(
    column: Locator,
    expectedValue: string
  ) {
    const actualValue = (await column.textContent())?.trim()
    const parsedExpectedValue = parseExpectedAnimalValue(expectedValue)
    if (parsedExpectedValue.type === 'date') {
      const birthDateYearMonth = this.formatDateYearMonth(
        parsedExpectedValue.value
      )
      expect(birthDateYearMonth).toEqual(actualValue)
      return
    }

    expect(parsedExpectedValue.value).toEqual(actualValue)
  }

  private async verifyAnimalsOnHoldingHeaders(expectedHeaders: string[]) {
    const tableHeaders = await this.page.locator('table thead tr th').all()
    expect(tableHeaders).toHaveLength(expectedHeaders.length)

    const actualHeaders = await Promise.all(
      tableHeaders.map(async (tableHeader) =>
        (await tableHeader.textContent())?.trim()
      )
    )

    for (const [index, expectedHeader] of expectedHeaders.entries()) {
      expect(expectedHeader).toEqual(actualHeaders[index])
    }
  }

  private async verifyPaginationInformation(
    start: number,
    offSet: number,
    totalNoOfItems: number
  ) {
    let expectedString = `Showing ${start} to ${offSet} of ${totalNoOfItems} result${totalNoOfItems > 1 ? 's' : ''}`
    if (totalNoOfItems < 25) {
      expectedString = `Showing ${totalNoOfItems} result${totalNoOfItems > 1 ? 's' : ''}`
    }
    const paginationInfo = this.page.getByText(expectedString)
    await paginationInfo.scrollIntoViewIfNeeded()
    await expect(paginationInfo).toBeVisible()
  }

  private async verifyNextAndPreviousLinkBehavior(
    startCounter: number,
    rowCount: number,
    totalNumberOfItems: number
  ) {
    const hasNextPage = startCounter + rowCount - 1 < totalNumberOfItems
    if (hasNextPage) {
      await expect(this.nextPaginationLink).toBeVisible()
    } else {
      await expect(this.nextPaginationLink).not.toBeVisible()
    }

    if (startCounter === 1) {
      await expect(this.previousPaginationLink).not.toBeVisible()
    } else {
      await expect(this.previousPaginationLink).toBeVisible()
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
    const expectedSearchResultHint = `${expectedSearchResults.length} result${expectedSearchResults.length > 1 ? 's' : ''} for '${searchTerm}'`
    await expect(this.page.getByText(expectedSearchResultHint)).toBeVisible()
    await expect(
      this.page.getByRole('link', { name: 'Clear search' })
    ).toBeVisible()
    await this.verifyAnimalsOnHolding(expectedSearchResults)
  }

  public async verifyNoResultsForSearchTerm(searchTerm: string) {
    const expectedSearchResultHint = `0 results for '${searchTerm}'`
    await expect(this.page.getByText(expectedSearchResultHint)).toBeVisible()
  }
}
