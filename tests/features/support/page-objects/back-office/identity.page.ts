import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getIdentitySelectors } from '../selectors/back-office/identity.selectors'
import { getEnv, TestEnv } from '../../../../../configs/env'
import { fakeUsers } from '../../../../utils/fake.users'

export class LisBackOfficeIdentityPage extends BasePage {
  public readonly signInButton: Locator
  public readonly emailInput: Locator
  public readonly passwordInput: Locator
  public readonly nextButton: Locator
  private readonly env: TestEnv

  constructor(page: Page) {
    super(page)
    this.env = getEnv()
    const selectors = getIdentitySelectors(this.env)
    this.signInButton = page.locator(selectors.signInButton)
    this.emailInput = page.locator(selectors.emailInput || '')
    this.passwordInput = page.locator(selectors.passwordInput || '')
    this.nextButton = page.locator(selectors.nextButton || '')
  }

  public async authenticate(
    userRole: string,
    email?: string,
    password?: string
  ) {
    if (this.env === 'local') {
      const user = fakeUsers[userRole as keyof typeof fakeUsers]
      if (!user) {
        throw new Error(`User role "${userRole}" not found in fakeUsers`)
      }

      const userToSelectRadio = this.page.getByRole('radio', {
        name: `${user.name} (${user.email})`
      })
      await userToSelectRadio.check()
      await this.signInButton.click()
    } else {
      await this.page.waitForURL('**/oauth2/v2.0/authorize**')
      await this.emailInput.fill(email || '')
      await this.nextButton.click()
      await this.passwordInput.fill(password || '')
      await this.signInButton.click()
    }
  }
}
