import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'
import { runInOrder } from '../../../../utils/run.in.order'

export class LisFrontOfficeMovementDetailsPage extends BasePage {
  readonly heading: Locator
  readonly earTagInput: Locator
  readonly animalItems: Locator
  readonly addAnotherAnimalButton: Locator
  readonly removeButton: Locator
  readonly dateInput: Locator

  constructor(page: Page) {
    super(page)
    this.heading = page.getByRole('heading', { name: 'Movement details' })
    this.earTagInput = page
      .getByRole('textbox', { name: /Ear tag number/ })
      .or(page.getByRole('combobox', { name: /Ear tag number/ }))
    this.animalItems = page.locator('.moj-add-another__item')
    this.addAnotherAnimalButton = page.getByRole('button', {
      name: 'Add another animal'
    })
    this.removeButton = page.getByRole('button', { name: 'Remove' })
    this.dateInput = page.getByRole('textbox', { name: 'Movement date' })
  }

  async submitMovementDetails(
    animals: { earTag: string; movementDate: string }[]
  ) {
    if (animals.length === 0) {
      throw new Error('At least one animal must be provided')
    }

    const currentAnimalCount = await this.earTagInput.count()
    const rowsToAdd = Math.max(animals.length - currentAnimalCount, 0)
    // Each click adds a row, which must appear before the next click
    await runInOrder(Array.from({ length: rowsToAdd }), async (_, index) => {
      await this.addAnotherAnimalButton.click()
      await expect(this.earTagInput).toHaveCount(currentAnimalCount + index + 1)
    })

    let lookupHasNoResults = false
    await runInOrder(animals, async (animal, index) => {
      if (lookupHasNoResults) return

      const animalItem = this.animalItems.nth(index)
      const earTagCombobox = animalItem.getByRole('combobox', {
        name: /Ear tag number/
      })
      let earTagInput: Locator

      // An empty ear tag leaves the field blank, e.g. to test the missing ear tag error
      if (animal.earTag) {
        if (await earTagCombobox.count()) {
          earTagInput = earTagCombobox
          await this.searchAutocomplete(earTagCombobox, animal.earTag)
          const suggestion = this.page.getByRole('option', {
            name: animal.earTag,
            exact: true
          })
          const noResults = animalItem
            .getByRole('option')
            .filter({ hasText: 'No results found' })
          await expect(suggestion.or(noResults)).toBeVisible()
          if (await noResults.isVisible()) {
            lookupHasNoResults = true
            return
          }
          await suggestion.click()
        } else {
          earTagInput = animalItem.getByRole('textbox', {
            name: /Ear tag number/
          })
          await earTagInput.fill(animal.earTag)
        }

        await expect(earTagInput).toHaveValue(animal.earTag)
      }

      const movementDateInput = this.dateInput.nth(index)
      await movementDateInput.fill(animal.movementDate)
      await expect(movementDateInput).toHaveValue(animal.movementDate)
    })

    // An ear tag not in the lookup only shows "No results found", so stop
    // here and leave it on screen for the next step to check
    if (lookupHasNoResults) return

    await this.continueButton.click()
  }

  async removeAnimals(animals: string[]) {
    if (animals.length === 0) {
      throw new Error('At least one animal identifier must be provided')
    }

    if (new Set(animals).size !== animals.length) {
      throw new Error('Animal identifiers to remove must be unique')
    }

    // Removes one at a time, as each removal renumbers the rows
    await runInOrder(animals, async (identifier) => {
      const animalItems = this.page.locator('.moj-add-another__item')
      const animalNumber = new RegExp(/^animal\s+(\d+)$/i).exec(identifier)?.[1]
      const items = await animalItems.all()

      // Only reads the rows, so all rows are checked at once
      const matches = await Promise.all(
        items.map(async (animalItem) => {
          const earTag = await animalItem
            .locator('input[name^="movement-ear-tags"]')
            .inputValue()
          const legend = (await animalItem.locator('legend').innerText()).trim()
          const matchesAnimalNumber =
            animalNumber !== undefined &&
            new RegExp(
              String.raw`^Animal\s+${animalNumber}(?:\s+of\s+\d+)?$`,
              'i'
            ).test(legend)
          return earTag === identifier || matchesAnimalNumber
        })
      )

      const matchingItem = items[matches.indexOf(true)]
      if (!matchingItem) {
        throw new Error(`No animal found matching "${identifier}"`)
      }
      await matchingItem.getByRole('button', { name: /^Remove/ }).click()
      await expect(animalItems).toHaveCount(items.length - 1)
    })
  }
}
