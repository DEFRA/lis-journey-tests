import { expect } from '@playwright/test'
import { Then, When } from '../../fixtures/test.fixture'
import { resolveInputDate } from '../../utils/dates'
import { DatePicker } from '../../page-objects/front-office/cattle/components/date.picker'

// These steps work on any cattle page with a date picker.
// The field is the date input's label, e.g. "Date of birth", "Date of death" or "Movement date".

When(
  'I select {string} from the {string} date picker',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).selectDate(resolveInputDate(date))
  }
)

When(
  'I type {string} into the {string} field',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).input.fill(resolveInputDate(date))
  }
)

When('I open the {string} date picker', async ({ page }, field: string) => {
  await DatePicker.forField(page, field).open()
})

When('I close the {string} date picker', async ({ page }, field: string) => {
  await DatePicker.forField(page, field).close()
})

When(
  'I tab to the {string} date picker button',
  async ({ page }, field: string) => {
    await DatePicker.forField(page, field).tabToChooseDateButton()
  }
)

// key is a Playwright key name, e.g. "Enter", "Space", "Escape" or "ArrowLeft"
When('I press {string}', async ({ page }, key: string) => {
  await page.keyboard.press(key)
})

Then(
  '{string} has focus in the {string} date picker',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).verifyDateHasFocus(
      resolveInputDate(date)
    )
  }
)

Then('the {string} date picker is closed', async ({ page }, field: string) => {
  await expect(DatePicker.forField(page, field).dialog).toBeHidden()
})

Then(
  'the {string} date picker button has focus',
  async ({ page }, field: string) => {
    await expect(
      DatePicker.forField(page, field).chooseDateButton
    ).toBeFocused()
  }
)

Then(
  'the {string} field shows {string}',
  async ({ page }, field: string, date: string) => {
    await expect(DatePicker.forField(page, field).input).toHaveValue(
      resolveInputDate(date)
    )
  }
)

Then(
  '{string} is unavailable in the {string} date picker',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).verifyDateIsUnavailable(
      resolveInputDate(date)
    )
  }
)

Then(
  '{string} is shown as today in the {string} date picker',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).verifyDateIsToday(
      resolveInputDate(date)
    )
  }
)

Then(
  '{string} is selected in the {string} date picker',
  async ({ page }, date: string, field: string) => {
    await DatePicker.forField(page, field).verifyDateIsSelected(
      resolveInputDate(date)
    )
  }
)
