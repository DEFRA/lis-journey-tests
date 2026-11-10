import { expect, Page } from '@playwright/test'
import { DataTable } from 'playwright-bdd'
import { Then, When } from '../fixtures/test.fixture'

// Generic steps for read-only pages that don't need their own page object.
// They work on any page in any journey.

// Shared so steps that switch to a new tab can check its heading the same way
const expectHeading = async (page: Page, heading: string) => {
  await expect(
    page.getByRole('heading', { name: heading, exact: true })
  ).toBeVisible()
}

// The value cell of a GOV.UK summary list row, found by its key, e.g. "Status"
const summaryValue = (page: Page, key: string) =>
  page
    .locator('.govuk-summary-list__row')
    .filter({
      has: page
        .locator('.govuk-summary-list__key')
        .getByText(key, { exact: true })
    })
    .locator('.govuk-summary-list__value')

// The visible sortable table. Tabbed pages keep hidden tables in the page, so those are skipped
const sortableTable = (page: Page) =>
  page
    .locator('table[data-module="moj-sortable-table"]')
    .filter({ visible: true })

const sortableHeader = (page: Page, column: string) =>
  sortableTable(page)
    .locator('thead th')
    .filter({ has: page.getByRole('button', { name: column, exact: true }) })

// Compares like the MOJ sortable table: numbers as numbers, everything else as text
const compareSortValues = (a: string, b: string) => {
  const numberA = Number(a)
  const numberB = Number(b)
  if (
    a !== '' &&
    b !== '' &&
    !Number.isNaN(numberA) &&
    !Number.isNaN(numberB)
  ) {
    return numberA - numberB
  }
  return a.localeCompare(b)
}

Then('I should see the heading {string}', async ({ page }, heading: string) => {
  await expectHeading(page, heading)
})

// Header row is the summary list keys, second row is their expected values
Then(
  'I verify the summary list has:',
  async ({ page }, dataTable: DataTable) => {
    const [expected] = dataTable.hashes()
    await Promise.all(
      Object.entries(expected).map(([key, value]) =>
        expect(summaryValue(page, key)).toHaveText(value)
      )
    )
  }
)

// Each click flips the column between ascending and descending
When('I sort the table by {string}', async ({ page }, column: string) => {
  await sortableHeader(page, column).getByRole('button').click()
})

// Checks the order of whatever rows are there, so it works when the data changes.
// Dates use their data-sort-value (e.g. 20250811) rather than the text shown
Then(
  'the table is sorted by {string} in {string} order',
  async ({ page }, column: string, direction: string) => {
    const header = sortableHeader(page, column)
    await expect(header).toHaveAttribute('aria-sort', direction)

    const headerTexts = await sortableTable(page)
      .locator('thead th')
      .allInnerTexts()
    const columnIndex = headerTexts.findIndex((text) => text.trim() === column)
    const values = await sortableTable(page)
      .locator(`tbody tr td:nth-child(${columnIndex + 1})`)
      .evaluateAll((cells) =>
        cells.map(
          (cell) =>
            cell.getAttribute('data-sort-value') ?? cell.textContent!.trim()
        )
      )

    // One row is always "sorted", so it would prove nothing
    expect(
      values.length,
      'need at least 2 rows to check sorting'
    ).toBeGreaterThan(1)

    const expected = [...values].sort(compareSortValues)
    if (direction === 'descending') expected.reverse()
    expect(values).toEqual(expected)
  }
)

// For values too long to match in full in a feature file
Then(
  'the {string} summary row contains {string}',
  async ({ page }, key: string, text: string) => {
    await expect(summaryValue(page, key)).toContainText(text)
  }
)

Then('I should see the message {string}', async ({ page }, message: string) => {
  await expect(page.getByText(message)).toBeVisible()
})

// Works on any table of animals, e.g. In progress, Cattle with errors, Cattle on holding.
// exact stops "UK 123456 30155" also matching "UK 123456 301550"
When(
  'I click on the {string} ear tag link',
  async ({ page }, earTag: string) => {
    await page.getByRole('link', { name: earTag, exact: true }).click()
  }
)

// For embedded and footer links that take you to another page
Then(
  'I should be navigated to the {string} page and the web address contains {string}',
  async ({ page }, heading: string, urlFragment: string) => {
    await expect(page.getByRole('heading', { name: heading })).toBeVisible()
    expect(page.url()).toContain(urlFragment)
  }
)

Then(
  'I verify the {string} email link is present',
  async ({ page }, email: string) => {
    await expect(page.locator(`a[href="mailto:${email}"]`)).toBeVisible()
  }
)

// For links with target="_blank". The checks run on the new tab, not the original page
Then(
  'I verify the {string} link opens the {string} page in a new tab and contains url {string}',
  async ({ page }, linkText: string, heading: string, urlFragment: string) => {
    const [newTab] = await Promise.all([
      page.context().waitForEvent('page'),
      page.getByRole('link', { name: linkText }).click()
    ])
    await expectHeading(newTab, heading)
    expect(newTab.url()).toContain(urlFragment)
  }
)
