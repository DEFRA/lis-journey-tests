import { Locator, Page } from '@playwright/test'
import { BasePage } from '../base.page'
import { getIdentitySelectors } from '../selectors/identity.selectors'
import { getEnv } from '../../../../../configs/env'
import { fakeUsers } from '../../../../utils/fake.users'

export class LisBackOfficeIdentityPage extends BasePage {
  public readonly signInButton: Locator

  constructor(page: Page) {
    super(page)
    const env = getEnv()
    const selectors = getIdentitySelectors(env)
    this.signInButton = page.getByRole('button', {
      name: selectors.signInButton
    })
  }

  public async authenticate(userRole: string) {
    const user = fakeUsers[userRole as keyof typeof fakeUsers]
    if (!user) {
      throw new Error(`User role "${userRole}" not found in fakeUsers`)
    }

    const userToSelectRadio = this.page.getByRole('radio', {
      name: `${user.name} (${user.email})`
    })
    await userToSelectRadio.check()
    await this.signInButton.click()
  }
}
