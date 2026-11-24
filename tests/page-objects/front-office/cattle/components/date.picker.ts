import { expect, Locator, Page } from '@playwright/test'
import { runInOrder } from '../../../../utils/run.in.order'

// The Heroku prototype uses the MOJ date picker and the MVP uses the LIS one.
// They work the same, but these locators differ, so each app keeps its own
const appLocators = {
  prototype: {
    wrapper: '.moj-datepicker',
    monthYearTitle: (dialog: Locator) =>
      dialog.locator('.moj-js-datepicker-month-year'),
    selectedDay: /moj-datepicker__button--selected/
  },
  mvp: {
    wrapper: '.lis-date-picker',
    monthYearTitle: (dialog: Locator) =>
      dialog.getByRole('heading', { level: 2 }),
    selectedDay: /lis-date-picker__button--selected/
  }
}

// The date picker attached to a date input, e.g. Date of birth.
// Dates are d/m/yyyy, which matches the data-testid on each day button.
export class DatePicker {
  readonly input: Locator
  readonly chooseDateButton: Locator
  readonly dialog: Locator
  readonly monthYearTitle: Locator
  readonly previousMonthButton: Locator
  readonly nextMonthButton: Locator
  readonly closeButton: Locator
  readonly selectedDayClass: RegExp

  constructor(page: Page, input: Locator) {
    // Only the prototype is on herokuapp
    const app = page.url().includes('herokuapp') ? 'prototype' : 'mvp'
    const locators = appLocators[app]

    // Scope to the picker wrapping this input, so pages with several date fields work.
    // The wrapper has no role or label, so this is the one place a class is needed
    const datePicker = page.locator(locators.wrapper).filter({ has: input })

    this.input = input
    this.chooseDateButton = datePicker.getByRole('button', {
      name: 'Choose date'
    })
    this.dialog = datePicker.getByRole('dialog')
    this.monthYearTitle = locators.monthYearTitle(this.dialog)
    this.selectedDayClass = locators.selectedDay
    this.previousMonthButton = this.dialog.getByRole('button', {
      name: 'Previous month'
    })
    this.nextMonthButton = this.dialog.getByRole('button', {
      name: 'Next month'
    })
    this.closeButton = this.dialog.getByRole('button', { name: 'Close' })
  }

  // Finds the picker for a date field by its label, e.g. "Date of death"
  static forField(page: Page, label: string) {
    return new DatePicker(page, page.getByRole('textbox', { name: label }))
  }

  dayButton(date: string) {
    return this.dialog.getByTestId(date)
  }

  async open() {
    await this.chooseDateButton.click()
    await expect(this.dialog).toBeVisible()
  }

  async close() {
    await this.closeButton.click()
    await expect(this.dialog).toBeHidden()
  }

  async goToMonthOf(date: string) {
    const [, month, year] = date.split('/').map(Number)
    const targetMonth = year * 12 + month

    const shown = new Date(`1 ${await this.monthYearTitle.innerText()}`)
    const shownMonth = shown.getFullYear() * 12 + shown.getMonth() + 1

    // Works out the clicks up front, e.g. 3 months back is 3 Previous month clicks
    const monthsToMove = targetMonth - shownMonth
    const monthButton =
      monthsToMove < 0 ? this.previousMonthButton : this.nextMonthButton
    await runInOrder(Array.from({ length: Math.abs(monthsToMove) }), () =>
      monthButton.click()
    )

    await this.verifyShowsMonthOf(date)
  }

  // Checks the title, e.g. "November 2026", without moving to the month
  async verifyShowsMonthOf(date: string) {
    const [, month, year] = date.split('/').map(Number)
    await expect(this.monthYearTitle).toHaveText(
      new Date(year, month - 1).toLocaleDateString('en-GB', {
        month: 'long',
        year: 'numeric'
      })
    )
  }

  async selectDate(date: string) {
    await this.open()
    await this.goToMonthOf(date)
    await this.dayButton(date).click()
    await expect(this.dialog).toBeHidden()
  }

  async verifyDateIsUnavailable(date: string) {
    await this.goToMonthOf(date)
    await expect(this.dayButton(date)).toHaveAttribute('aria-disabled', 'true')
  }

  async verifyDateIsToday(date: string) {
    await this.goToMonthOf(date)
    await expect(this.dayButton(date)).toHaveAttribute('aria-current', 'date')
  }

  // Tabs from the date input to the Choose date button, as a keyboard user would
  async tabToChooseDateButton() {
    await this.input.focus()
    await this.input.press('Tab')
    await expect(this.chooseDateButton).toBeFocused()
  }

  // No goToMonthOf here: clicking the month buttons would move focus out of the grid
  async verifyDateHasFocus(date: string) {
    await expect(this.dayButton(date)).toBeFocused()
  }

  // The selected day has no aria attribute, only a class
  async verifyDateIsSelected(date: string) {
    await expect(this.dayButton(date)).toHaveClass(this.selectedDayClass)
  }
}
