import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getIdentitySelectors } from '../selectors/front-office/identity.selectors'
import { getEnv, TestEnv } from '../../../../../configs/env'
import { fakeUsers } from '../../../../utils/fake.users'
import { fetchDefraUserCredentials } from '../../../../utils/defra.users'

export class LisFrontOfficeIdentityPage extends BasePage {
  public readonly signInButton: Locator
  public readonly emailInput: Locator
  public readonly passwordInput: Locator
  public readonly continueButton: Locator
  private readonly env: TestEnv

  constructor(page: Page) {
    super(page)
    this.env = getEnv()
    const selectors = getIdentitySelectors(this.env)
    this.signInButton = page.locator(selectors.signInButton)
    this.emailInput = page.locator(selectors.emailInput || '')
    this.passwordInput = page.locator(selectors.passwordInput || '')
    this.continueButton = page.locator(selectors.continueButton || '')
  }

  public async authenticate(userRole: string) {
    userRole = `${userRole.toLowerCase().trim()}Cph`

    if (this.env === 'local') {
      // Append "Cph" to the userRole for front office users
      await this.signInButton.waitFor({ state: 'visible' })
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
      const user = await fetchDefraUserCredentials(userRole, 'frontoffice')
      await this.page.waitForURL('**/registration/oidc/authorize/**')
      await this.page.waitForURL('**/sign-in-or-create')
      await this.signInButton.click()
      await this.page.waitForURL('**/enter-email')
      await this.emailInput.fill(user.email || '')
      await this.continueButton.click()
      await this.page.waitForURL('**/enter-password')
      await this.passwordInput.fill(user.password || '')
      await this.continueButton.click()
    }
  }
}
