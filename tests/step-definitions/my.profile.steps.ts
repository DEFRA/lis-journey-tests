import { DataTable } from 'playwright-bdd'
import { Then } from '../fixtures/test.fixture'
import { expect } from '@playwright/test'

Then(
  'the My Profile page should display the following information:',
  async ({ lisFrontOfficeMyProfilePage }, dataTable: DataTable) => {
    await expect(lisFrontOfficeMyProfilePage.heading).toBeVisible()
    await lisFrontOfficeMyProfilePage.verifyTableValuesAreVisible(
      dataTable.hashes().map(({ Value }) => Value)
    )
  }
)
