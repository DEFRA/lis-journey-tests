import { DataTable } from 'playwright-bdd'
import { Then } from '../fixtures/test.fixture'

Then(
  'I should see the following cattle error record details:',
  async function (
    { lisFrontOfficeCattleErrorRecordDetailPage },
    dataTable: DataTable
  ) {
    await lisFrontOfficeCattleErrorRecordDetailPage.verifyErrorRecordDetails(
      dataTable.hashes()
    )
  }
)
