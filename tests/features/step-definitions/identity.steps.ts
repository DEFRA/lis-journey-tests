import { Given, Then } from '../../fixtures/test.fixture'

Given(
  /^I sign in as a (.*) user$/,
  async ({ lisBackOfficeIdentityPage }, userRole: string) => {
    await lisBackOfficeIdentityPage.authenticate(userRole)
  }
)

Then(
  /^the (front|back) office user should be signed in successfully$/,
  async function (
    { lisBackOfficeHomePage, lisFrontOfficeHomePage },
    officeType: string
  ) {
    if (officeType === 'back') {
      await lisBackOfficeHomePage.verifySignedIn()
    } else {
      await lisFrontOfficeHomePage.verifySignedIn()
    }
  }
)

Given(
  /^I sign in as a front office user with(?: a)? (.*) CPH holdings?$/,
  async function (
    { lisFrontOfficeHomePage, lisFrontOfficeIdentityPage },
    userRole: string
  ) {
    await lisFrontOfficeHomePage.clickStartNowLink()
    await lisFrontOfficeIdentityPage.authenticate(userRole)
  }
)
