import { Given, Then } from '../../fixtures/test.fixture'

Given(
  /^I sign in as a (.*) user$/,
  async ({ lisBackOfficeIdentityPage }, userRole: string) => {
    await lisBackOfficeIdentityPage.authenticate(userRole)
  }
)

Then(
  /^the user should be signed in successfully$/,
  async function ({ lisBackOfficeHomePage }) {
    await lisBackOfficeHomePage.verifySignedIn()
  }
)
