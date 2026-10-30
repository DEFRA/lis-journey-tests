import { expect, Locator, Page } from '@playwright/test'

// The MOJ date picker attached to a date input, e.g. Date of birth.
// Dates are d/m/yyyy, which matches the data-testid on each day button.
export class DatePicker {
  readonly input: Locator
  readonly chooseDateButton: Locator
  readonly dialog: Locator
  readonly monthYearTitle: Locator
  readonly previousMonthButton: Locator
  readonly nextMonthButton: Locator
  readonly closeButton: Locator

  constructor(page: Page, input: Locator) {
    // Scope to the picker wrapping this input, so pages with several date fields work
    const datePicker = page.locator('.moj-datepicker').filter({ has: input })

    this.input = input
    this.chooseDateButton = datePicker.getByRole('button', {
      name: 'Choose date'
    })
    this.dialog = datePicker.getByRole('dialog')
    this.monthYearTitle = this.dialog.locator('.moj-js-datepicker-month-year')
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

    // Safety limit so a wrong date can't loop forever
    for (let clicks = 0; clicks < 240; clicks++) {
      const shown = new Date(`1 ${await this.monthYearTitle.innerText()}`)
      const shownMonth = shown.getFullYear() * 12 + shown.getMonth() + 1

      if (shownMonth === targetMonth) return

      if (shownMonth > targetMonth) {
        await this.previousMonthButton.click()
      } else {
        await this.nextMonthButton.click()
      }
    }

    throw new Error(`Could not navigate the date picker to ${date}`)
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

  async verifyDateIsSelected(date: string) {
    await expect(this.dayButton(date)).toHaveClass(
      /moj-datepicker__button--selected/
    )
  }
}
