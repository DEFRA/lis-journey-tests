import { When } from '../fixtures/test.fixture'

When(
  'I navigate to the {string} holdings detail page for the CPH {string}',
  async function (
    { lisFrontOfficeHomePage },
    species: string,
    cphNumber: string
  ) {
    await lisFrontOfficeHomePage.navigateToHoldingDetails(species, cphNumber)
  }
)
