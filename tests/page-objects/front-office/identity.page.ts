import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { fakeUsers } from '../../utils/fake.users'
import { fetchDefraUserCredentials } from '../../utils/defra.users'

export class LisFrontOfficeIdentityPage extends BasePage {
  readonly signInButton: Locator
  readonly emailInput: Locator
  readonly passwordInput: Locator
  readonly continueButton: Locator

  constructor(page: Page) {
    super(page)
    this.signInButton = page.getByRole('button', { name: 'Sign in' })
    this.emailInput = page.getByRole('textbox', { name: /email/i })
    this.passwordInput = page.getByRole('textbox', {
      name: 'Enter your password'
    })
    this.continueButton = page.getByRole('button', { name: 'Continue' })
  }

  // Uses the fake login picker when the page shows it, otherwise signs in through Defra ID
  async authenticate(userRole: string) {
    // Append "Cph" to the userRole for front office users
    userRole = `${userRole.toLowerCase().trim()}Cph`
    const user = fakeUsers[userRole as keyof typeof fakeUsers]
    if (!user) {
      throw new Error(`User role "${userRole}" not found in fakeUsers`)
    }
    const userToSelectRadio = this.page.getByRole('radio', {
      name: `${user.name} (${user.email})`
    })

    // Defra ID's first page also has a Sign in button, but no user radios
    if (await this.showsFakeLoginPicker(userToSelectRadio, this.signInButton)) {
      await userToSelectRadio.check()
      await this.signInButton.click()
    } else {
      const defraUser = fetchDefraUserCredentials(userRole, 'frontoffice')
      await this.page.waitForURL('**/sign-in-or-create')
      await this.signInButton.click()
      await this.page.waitForURL('**/enter-email')
      await this.emailInput.fill(defraUser.email || '')
      await this.continueButton.click()
      await this.page.waitForURL('**/enter-password')
      await this.passwordInput.fill(defraUser.password || '')
      await this.continueButton.click()
    }
  }
}
