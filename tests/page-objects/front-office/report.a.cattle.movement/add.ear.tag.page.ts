import { Locator, Page } from '@playwright/test'
import { BasePage } from '../../base.page'

export class AddEarTagPage extends BasePage {
  readonly heading: Locator
  readonly earTagInput: Locator
  readonly addAnotherAnimalButton: Locator
  readonly removeButton: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Add ear tag' })
    this.earTagInput = page.getByRole('textbox', { name: /Ear tag number/ })
    this.addAnotherAnimalButton = page.getByRole('button', {
      name: 'Add another animal'
    })
    this.removeButton = page.getByRole('button', { name: 'Remove' })
  }

  async submitEarTagNumbers(earTags: string[]) {
    if (earTags.length === 0) {
      throw new Error('At least one ear tag number must be provided')
    }

    for (let index = 1; index < earTags.length; index++) {
      // Each click adds a row needed before the next iteration.
      await this.addAnotherAnimalButton.click()
    }

    for (const [index, earTag] of earTags.entries()) {
      // Keep field updates ordered with the rows created above.
      await this.earTagInput.nth(index).fill(earTag)
    }

    await this.continueButton.click()
  }

  async removeAnimals(earTags: string[]) {
    if (earTags.length === 0) {
      throw new Error('At least one ear tag number must be provided')
    }

    if (new Set(earTags).size !== earTags.length) {
      throw new Error('Ear tag numbers to remove must be unique')
    }

    for (const earTag of earTags) {
      const animalItems = this.page.locator('.moj-add-another__item')
      let matchingItem: Locator | undefined
      // Re-read the list after each removal.
      const animalCount = await animalItems.count()

      for (let index = 0; index < animalCount; index++) {
        const animalItem = animalItems.nth(index)
        // Each removal changes the list, so inspect the current items sequentially.
        if ((await animalItem.locator('input').inputValue()) === earTag) {
          matchingItem = animalItem
          break
        }
      }

      if (!matchingItem) {
        throw new Error(`No animal found with ear tag number "${earTag}"`)
      }
      // The next requested tag is located after this row is removed.
      await matchingItem.getByRole('button', { name: /^Remove/ }).click()
    }
  }

  async removeAllAnimals() {
    // Re-check the number of remaining rows after each removal.
    while ((await this.removeButton.count()) > 0) {
      // Each click removes a row and changes the available buttons.
      await this.removeButton.first().click()
    }
  }
}
