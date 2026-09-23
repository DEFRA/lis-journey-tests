import { When } from '../../fixtures/test.fixture'

When(
  /^I navigate to the "([^"]*)" holdings detail page for the CPH "([^"]*)"$/,
  async function (
    { lisFrontOfficeHomePage },
    species: string,
    cphNumber: string
  ) {
    await lisFrontOfficeHomePage.navigateToHoldingDetails(species, cphNumber)
  }
)
