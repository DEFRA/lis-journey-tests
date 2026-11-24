import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { fakeUsers } from '../../utils/fake.users'

export class LisBackOfficeIdentityPage extends BasePage {
  readonly signInButton: Locator
  readonly emailInput: Locator
  readonly passwordInput: Locator
  readonly nextButton: Locator

  constructor(page: Page) {
    super(page)
    this.signInButton = page.getByRole('button', { name: 'Sign in' })
    this.emailInput = page.getByRole('textbox', { name: /email/i })
    this.passwordInput = page.getByLabel(/password/i)
    this.nextButton = page.getByRole('button', { name: 'Next' })
  }

  // Uses the fake login picker when the page shows it, otherwise signs in through Entra ID
  async authenticate(userRole: string, email?: string, password?: string) {
    const user = fakeUsers[userRole as keyof typeof fakeUsers]
    if (!user) {
      throw new Error(`User role "${userRole}" not found in fakeUsers`)
    }
    const userToSelectRadio = this.page.getByRole('radio', {
      name: `${user.name} (${user.email})`
    })

    // Entra ID's first page asks for the email address
    if (await this.showsFakeLoginPicker(userToSelectRadio, this.emailInput)) {
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
