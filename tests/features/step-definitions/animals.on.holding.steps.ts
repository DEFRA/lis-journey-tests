import { Then, When } from '../../fixtures/test.fixture'
import { expect } from '@playwright/test'
import { DataTable } from 'playwright-bdd'

Then(
  /^the animals on holding caption should display "([^"]*)"$/,
  async function (
    { lisFrontOfficeAnimalsOnHoldingPage },
    expectedCaption: string
  ) {
    await expect(lisFrontOfficeAnimalsOnHoldingPage.headingCaption).toHaveText(
      expectedCaption
    )
  }
)

Then(
  /^the animals on holding heading should display "([^"]*)"$/,
  async function (
    { lisFrontOfficeAnimalsOnHoldingPage },
    expectedHeading: string
  ) {
    await expect(lisFrontOfficeAnimalsOnHoldingPage.heading).toHaveText(
      expectedHeading
    )
  }
)

Then(
  'I should be able to search for an animal using ear tag, sex or breed',
  async function ({ lisFrontOfficeAnimalsOnHoldingPage }) {
    await lisFrontOfficeAnimalsOnHoldingPage.verifySearchCapabilities()
  }
)

Then(
  'I should see the following animals on holding:',
  async function (
    { lisFrontOfficeAnimalsOnHoldingPage },
    dataTable: DataTable
  ) {
    const expectedDAnimalsOnHolding = dataTable.hashes()
    await lisFrontOfficeAnimalsOnHoldingPage.verifyAnimalsOnHolding(
      expectedDAnimalsOnHolding
    )
  }
)

When(
  'I search using search term {string}',
  async function ({ lisFrontOfficeAnimalsOnHoldingPage }, searchTerm: string) {
    await lisFrontOfficeAnimalsOnHoldingPage.searchUsing(searchTerm)
  }
)

Then(
  'I should see the following search results for {string}:',
  async function (
    { lisFrontOfficeAnimalsOnHoldingPage },
    searchTerm: string,
    dataTable: DataTable
  ) {
    const expectedDAnimalsOnHoldingSearchResult = dataTable.hashes()
    await lisFrontOfficeAnimalsOnHoldingPage.verifyAnimalsOnHoldingSearchResult(
      searchTerm,
      expectedDAnimalsOnHoldingSearchResult
    )
  }
)

Then(
  'I should see no results returned for search term {string}',
  async function ({ lisFrontOfficeAnimalsOnHoldingPage }, searchTerm: string) {
    await lisFrontOfficeAnimalsOnHoldingPage.verifyNoResultsForSearchTerm(
      searchTerm
    )
  }
)
