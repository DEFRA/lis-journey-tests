import { expect, Page } from '@playwright/test'
import { faker } from '@faker-js/faker'
import { DataTable } from 'playwright-bdd'
import { runInOrder } from '../../utils/run.in.order'
import { Then, When } from '../../fixtures/test.fixture'

// These steps work on any cattle form page.
// The field is the input's label, e.g. "Animal ear tag number" or "Breed".

// .and(input) skips the <select> that autocomplete fields start as before their JS loads
const fieldByLabel = (page: Page, label: string) =>
  page
    .getByLabel(label, { exact: true })
    .and(page.locator('input'))
    .filter({ visible: true })

const formGroupFor = (page: Page, label: string) =>
  page.locator('.govuk-form-group').filter({ has: fieldByLabel(page, label) })

// Only this field's suggestions, so pages with two lookups work
const suggestionsFor = (page: Page, label: string) =>
  formGroupFor(page, label).getByRole('option')

// Ignores spaces and case, so "uk123 456" matches "UK123456"
const normalise = (text: string) => text.replace(/\s/g, '').toUpperCase()

When(
  'I enter {int} characters into the {string} field',
  async ({ page }, length: number, label: string) => {
    await fieldByLabel(page, label).fill(faker.string.alpha(length))
  }
)

// The page is its heading, e.g. "Calf details". Waiting for it first stops
// a fast click landing on the previous page's Continue button
When('I continue from the {string} page', async ({ page }, heading: string) => {
  await expect(
    page.getByRole('heading', { name: heading, exact: true })
  ).toBeVisible()
  await page.getByRole('button', { name: 'Continue' }).click()
})

// Types into a lookup field without picking a suggestion, e.g. for values with no results
When(
  'I search for {string} in the {string} field',
  async ({ page }, value: string, label: string) => {
    const field = fieldByLabel(page, label)
    await expect(field).toBeVisible()
    await field.fill(value)
  }
)

When(
  'I select {string} from the {string} field suggestions',
  async ({ page }, option: string, label: string) => {
    await suggestionsFor(page, label)
      .filter({ hasText: option })
      .first()
      .click()
    await expect(fieldByLabel(page, label)).toHaveValue(option)
  }
)

Then(
  'the {string} field shows No results found',
  async ({ page }, label: string) => {
    await expect(
      suggestionsFor(page, label).filter({ hasText: 'No results found' })
    ).toBeVisible()
  }
)

Then(
  'the {string} field suggests {string}',
  async ({ page }, label: string, option: string) => {
    await expect(
      suggestionsFor(page, label).filter({ hasText: option })
    ).toBeVisible()
  }
)

// Waits for the list to load first, so an empty list can't pass by mistake
Then(
  'the {string} field does not suggest {string}',
  async ({ page }, label: string, option: string) => {
    await expect(suggestionsFor(page, label).first()).toBeVisible()
    await expect(
      suggestionsFor(page, label).filter({ hasText: option })
    ).toHaveCount(0)
  }
)

Then(
  'every suggestion in the {string} field contains {string}',
  async ({ page }, label: string, searchTerm: string) => {
    const suggestions = suggestionsFor(page, label)
    await expect(suggestions.first()).toBeVisible()
    for (const suggestion of await suggestions.allInnerTexts()) {
      expect(normalise(suggestion)).toContain(normalise(searchTerm))
    }
  }
)

Then(
  'the {string} field has the value {string}',
  async ({ page }, label: string, value: string) => {
    await expect(fieldByLabel(page, label)).toHaveValue(value)
  }
)

// Checks only this field's error, so other empty fields' errors don't matter
Then(
  'the {string} field shows the error {string}',
  async ({ page }, label: string, error: string) => {
    await expect(
      formGroupFor(page, label).locator('.govuk-error-message')
    ).toContainText(error)
  }
)

// The page is its heading, e.g. "Dam details". Same caption locator as BasePage.headingCaption
Then(
  'the {string} page caption shows {string}',
  async ({ page }, heading: string, caption: string) => {
    await expect(
      page.getByRole('heading', { name: heading, exact: true })
    ).toBeVisible()
    await expect(page.locator('.govuk-caption-l')).toHaveText(caption)
  }
)

// Searches the short term then the longer one, and checks the longer one suggests fewer.
// Waits until every suggestion matches the longer term, so the old list isn't counted
Then(
  'searching {string} then {string} in the {string} field suggests fewer matches',
  async ({ page }, shortTerm: string, longTerm: string, label: string) => {
    const field = fieldByLabel(page, label)
    const suggestions = suggestionsFor(page, label)

    await field.fill(shortTerm)
    await expect(suggestions.first()).toBeVisible()
    const shortTermCount = await suggestions.count()

    await field.fill(longTerm)
    await expect
      .poll(async () =>
        (await suggestions.allInnerTexts()).every((suggestion) =>
          normalise(suggestion).includes(normalise(longTerm))
        )
      )
      .toBe(true)
    expect(await suggestions.count()).toBeLessThan(shortTermCount)
  }
)

When('I select the {string} radio', async ({ page }, option: string) => {
  await page.getByRole('radio', { name: option, exact: true }).check()
})

When('I focus the {string} field', async ({ page }, label: string) => {
  await fieldByLabel(page, label).focus()
})

// Presses Tab once per row and checks the row's element has focus, e.g. | button | Continue |.
// Names are exact so "Male" doesn't also match "Female"
Then(
  'pressing Tab moves focus through:',
  async ({ page }, dataTable: DataTable) => {
    await runInOrder(dataTable.hashes(), async ({ Role, Name }) => {
      await page.keyboard.press('Tab')
      await expect(
        page
          .getByRole(Role as Parameters<Page['getByRole']>[0], {
            name: Name,
            exact: true
          })
          .filter({ visible: true })
      ).toBeFocused()
    })
  }
)

Then('I navigate back to Check Calf Details page', async ({ page }) => {
  await page.goBack()
  await page.goBack()
  await page.goBack()
})

Then('I navigate back to Check Calf Details page alt', async ({ page }) => {
  await page.goBack()
  await page.goBack()
})
