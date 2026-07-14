import { Page } from '@playwright/test'
import { BasePage } from '../base.page'

export class LisFrontOfficeHomePage extends BasePage {
  constructor(page: Page) {
    super(page)
  }

  public async navigateToHomePage() {
    await this.goto('/')
  }
}
