import { Given } from '../../fixtures/test.fixture'

Given(
  /^I am authenticated as a back office (.*) user$/,
  async (
    { lisBackOfficeHomePage, lisBackOfficeIdentityPage },
    userRole: string
  ) => {
    await lisBackOfficeHomePage.navigateToHomePage()
    await lisBackOfficeIdentityPage.authenticate(userRole)
    await lisBackOfficeHomePage.verifySignedIn()
  }
)

Given(
  /^I am authenticated as a front office user with(?: a)? (.*) CPH holding$/,
  async function (
    { lisFrontOfficeHomePage, lisFrontOfficeIdentityPage },
    userRole: string
  ) {
    await lisFrontOfficeHomePage.navigateToHomePage()
    await lisFrontOfficeHomePage.clickStartNowLink()
    await lisFrontOfficeIdentityPage.authenticate(userRole)
    await lisFrontOfficeHomePage.verifySignedIn()
  }
)
