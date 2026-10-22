import { expect, Locator, Page } from '@playwright/test'
import { BasePage } from '../../../base.page'

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

    let currentAnimalCount = await this.earTagInput.count()
    while (currentAnimalCount < animals.length) {
      // Each click adds a row needed before the next iteration.
      await this.addAnotherAnimalButton.click()
      currentAnimalCount++
      await expect(this.earTagInput).toHaveCount(currentAnimalCount)
    }

    for (const [index, animal] of animals.entries()) {
      const animalItem = this.animalItems.nth(index)
      const earTagCombobox = animalItem.getByRole('combobox', {
        name: /Ear tag number/
      })
      let earTagInput: Locator

      if (await earTagCombobox.count()) {
        earTagInput = earTagCombobox
        await earTagCombobox.fill(animal.earTag)
        const suggestion = this.page.getByRole('option', {
          name: animal.earTag,
          exact: true
        })
        await suggestion.waitFor({ state: 'visible' })
        await suggestion.click()
      } else {
        earTagInput = animalItem.getByRole('textbox', {
          name: /Ear tag number/
        })
        await earTagInput.fill(animal.earTag)
      }

      await expect(earTagInput).toHaveValue(animal.earTag)

      const movementDateInput = this.dateInput.nth(index)
      await movementDateInput.fill(animal.movementDate)
      await expect(movementDateInput).toHaveValue(animal.movementDate)
    }

    await this.continueButton.click()
    await expect(
      this.page.getByRole('heading', { name: 'Check movement details' })
    ).toBeVisible()
  }

  async removeAnimals(animals: string[]) {
    if (animals.length === 0) {
      throw new Error('At least one animal identifier must be provided')
    }

    if (new Set(animals).size !== animals.length) {
      throw new Error('Animal identifiers to remove must be unique')
    }

    for (const identifier of animals) {
      const animalItems = this.page.locator('.moj-add-another__item')
      let matchingItem: Locator | undefined
      const animalNumber = identifier.match(/^animal\s+(\d+)$/i)?.[1]
      const animalCount = await animalItems.count()

      for (let index = 0; index < animalCount; index++) {
        const animalItem = animalItems.nth(index)
        const earTagInput = animalItem.locator(
          'input[name^="movement-ear-tags"]'
        )
        const matchesEarTag = (await earTagInput.inputValue()) === identifier
        const matchesAnimalNumber =
          animalNumber !== undefined &&
          new RegExp(
            `^Animal\\s+${animalNumber}(?:\\s+of\\s+\\d+)?$`,
            'i'
          ).test((await animalItem.locator('legend').innerText()).trim())

        if (matchesEarTag || matchesAnimalNumber) {
          matchingItem = animalItem
          break
        }
      }

      if (!matchingItem) {
        throw new Error(`No animal found matching "${identifier}"`)
      }
      await matchingItem.getByRole('button', { name: /^Remove/ }).click()
      await expect(animalItems).toHaveCount(animalCount - 1)
    }
  }
}
