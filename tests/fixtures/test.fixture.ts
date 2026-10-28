import { request, Page } from '@playwright/test'
import { test as base, createBdd } from 'playwright-bdd'
import { LisFrontOfficeClient } from '../features/support/api/lis.front.office.client'
import { LisBackOfficeClient } from '../features/support/api/lis.back.office.client'
import { LisFrontOfficeHomePage } from '../page-objects/front-office/home.page'
import { LisBackOfficeHomePage } from '../page-objects/back-office/home.page'
import { LisBackOfficeIdentityPage } from '../page-objects/back-office/identity.page'
import { LisFrontOfficeIdentityPage } from '../page-objects/front-office/identity.page'
import { LisFrontOfficeHoldingsPage } from '../page-objects/front-office/holdings.page'
import { LisFrontOfficeAnimalsOnHoldingPage } from '../page-objects/front-office/animals.on.holding.page'
import { LisFrontOfficeCattleHoldingOverviewPage } from '../page-objects/front-office/cattle/cattle.holding.overview.page'
import { LisFrontOfficeMyProfilePage } from '../page-objects/front-office/my.profile.page'
import { LisFrontOfficeCattleDetailsPage } from '../page-objects/front-office/cattle/cattle.details.page'
import { LisFrontOfficeRegisterCalfDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/calf.details.page'
import { LisFrontOfficeDamDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/dam.details.page'
import { LisFrontOfficeGeneticDamDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/genetic.dam.details.page'
import { LisFrontOfficeSurrogateDamDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/surrogate.dam.details.page'
import { LisFrontOfficeSireDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/sire.details.page'
import { LisFrontOfficeCheckCalfDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/check.calf.details.page'
import { LisFrontOfficeSubmitCattleRegistrationPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/submit.cattle.registration.page'
import { LisFrontOfficeRegisterNewCattleBirthPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/register.new.cattle.births.page'
import { LisFrontOfficeRegisterCattleBirthPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/register.cattle.birth.page'
import { LisFrontOfficeCancelDraftRegistrationPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/cancel.draft.registration.page'
import { LisFrontOfficeCancelThisRegistrationPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/cancel.this.registration.page'
import { LisFrontOfficeSubmissionDetailsPage } from '../page-objects/front-office/cattle/register.a.cattle.birth/submission.details.page'
import { LisFrontOfficeMovementDetailsPage } from '../page-objects/front-office/cattle/report.a.cattle.movement/movement.details'
import { LisFrontOfficeCheckMovementDetailsPage } from '../page-objects/front-office/cattle/report.a.cattle.movement/check.movement.details.page'
import { LisFrontOfficeOnOrOffMovementPage } from '../page-objects/front-office/cattle/report.a.cattle.movement/on.or.off.movement.page'
import { LisFrontOfficeReportACattleMovementPage } from '../page-objects/front-office/cattle/report.a.cattle.movement/report.a.cattle.movement.page'
import { LisFrontOfficeSubmitMovementReportPage } from '../page-objects/front-office/cattle/report.a.cattle.movement/submit.movement.report.page'
import { LisFrontOfficeCheckAnimalDetailsPage } from '../page-objects/front-office/cattle/report.a.cattle.death/check.animal.details.page'
import { LisFrontOfficeIsTheAnimalRegisteredPage } from '../page-objects/front-office/cattle/report.a.cattle.death/is.the.animal.registered.page'
import { LisFrontOfficeAnimalDetailsPage } from '../page-objects/front-office/cattle/report.a.cattle.death/animal.details.page'
import { LisFrontOfficeReportCattleDeathsPage } from '../page-objects/front-office/cattle/report.a.cattle.death/report.cattle.deaths.page'
import { LisFrontOfficeSubmitCattleDeathPage } from '../page-objects/front-office/cattle/report.a.cattle.death/submit.cattle.death.page'
import { LisFrontOfficeUnregisteredAnimalDetailsPage } from '../page-objects/front-office/cattle/report.a.cattle.death/unregistered.animal.details.page'
import { LisFrontOfficeExportCattleDataPage } from '../page-objects/front-office/cattle/download.list.of.cattle.on.your.holding/export.cattle.data.page'
import { LisFrontOfficeCattleErrorRecordDetailPage } from '../page-objects/front-office/cattle/cattle.error.record.detail.page'
import { LisFrontOfficeCattleErrorRecordPage } from '../page-objects/front-office/cattle/cattle.error.record.page'
import { LisFrontOfficeAnimalsOnHoldingPage as LisFrontOfficeCattleOnHoldingPage } from '../page-objects/front-office/cattle/cattle.on.holding.page'
import { LisFrontOfficePendingValidationPage } from '../page-objects/front-office/cattle/pending.validation.page'
import AxeBuilder from '@axe-core/playwright'

const accessibilityTags = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa']

export const test = base.extend<{
  lisFrontOfficeClient: LisFrontOfficeClient
  lisBackOfficeClient: LisBackOfficeClient
  lisFrontOfficeHomePage: LisFrontOfficeHomePage
  lisBackOfficeHomePage: LisBackOfficeHomePage
  lisBackOfficeIdentityPage: LisBackOfficeIdentityPage
  lisFrontOfficeIdentityPage: LisFrontOfficeIdentityPage
  lisFrontOfficeHoldingDetailsPage: LisFrontOfficeHoldingsPage
  lisFrontOfficeAnimalsOnHoldingPage: LisFrontOfficeAnimalsOnHoldingPage
  lisFrontOfficeCattleHoldingOverviewPage: LisFrontOfficeCattleHoldingOverviewPage
  lisFrontOfficeMyProfilePage: LisFrontOfficeMyProfilePage
  lisFrontOfficeCattleDetailsPage: LisFrontOfficeCattleDetailsPage
  lisFrontOfficeRegisterCalfDetailsPage: LisFrontOfficeRegisterCalfDetailsPage
  lisFrontOfficeDamDetailsPage: LisFrontOfficeDamDetailsPage
  lisFrontOfficeGeneticDamDetailsPage: LisFrontOfficeGeneticDamDetailsPage
  lisFrontOfficeSurrogateDamDetailsPage: LisFrontOfficeSurrogateDamDetailsPage
  lisFrontOfficeSireDetailsPage: LisFrontOfficeSireDetailsPage
  lisFrontOfficeCheckCalfDetailsPage: LisFrontOfficeCheckCalfDetailsPage
  lisFrontOfficeSubmitCattleRegistrationPage: LisFrontOfficeSubmitCattleRegistrationPage
  lisFrontOfficeRegisterNewCattleBirthPage: LisFrontOfficeRegisterNewCattleBirthPage
  lisFrontOfficeRegisterCattleBirthPage: LisFrontOfficeRegisterCattleBirthPage
  lisFrontOfficeCancelDraftRegistrationPage: LisFrontOfficeCancelDraftRegistrationPage
  lisFrontOfficeCancelThisRegistrationPage: LisFrontOfficeCancelThisRegistrationPage
  lisFrontOfficeSubmissionDetailsPage: LisFrontOfficeSubmissionDetailsPage
  lisFrontOfficeMovementDetailsPage: LisFrontOfficeMovementDetailsPage
  lisFrontOfficeCheckMovementDetailsPage: LisFrontOfficeCheckMovementDetailsPage
  lisFrontOfficeOnOrOffMovementPage: LisFrontOfficeOnOrOffMovementPage
  lisFrontOfficeReportACattleMovementPage: LisFrontOfficeReportACattleMovementPage
  lisFrontOfficeSubmitMovementReportPage: LisFrontOfficeSubmitMovementReportPage
  lisFrontOfficeCheckAnimalDetailsPage: LisFrontOfficeCheckAnimalDetailsPage
  lisFrontOfficeIsTheAnimalRegisteredPage: LisFrontOfficeIsTheAnimalRegisteredPage
  lisFrontOfficeAnimalDetailsPage: LisFrontOfficeAnimalDetailsPage
  lisFrontOfficeReportCattleDeathsPage: LisFrontOfficeReportCattleDeathsPage
  lisFrontOfficeSubmitCattleDeathPage: LisFrontOfficeSubmitCattleDeathPage
  lisFrontOfficeUnregisteredAnimalDetailsPage: LisFrontOfficeUnregisteredAnimalDetailsPage
  lisFrontOfficeExportCattleDataPage: LisFrontOfficeExportCattleDataPage
  lisFrontOfficeCattleErrorRecordDetailPage: LisFrontOfficeCattleErrorRecordDetailPage
  lisFrontOfficeCattleErrorRecordPage: LisFrontOfficeCattleErrorRecordPage
  lisFrontOfficeCattleOnHoldingPage: LisFrontOfficeCattleOnHoldingPage
  lisFrontOfficePendingValidationPage: LisFrontOfficePendingValidationPage
  axeFrontOfficeBuilder: AxeBuilder
  axeBackOfficeBuilder: AxeBuilder
  frontOfficePage: Page
  backOfficePage: Page
}>({
  frontOfficePage: async ({ page }, use) => {
    await use(page)
  },

  backOfficePage: async ({ page }, use) => {
    await use(page)
  },

  axeFrontOfficeBuilder: async ({ frontOfficePage }, use) => {
    await use(
      new AxeBuilder({
        page: frontOfficePage as unknown as ConstructorParameters<
          typeof AxeBuilder
        >[0]['page']
      }).withTags(accessibilityTags)
    )
  },

  axeBackOfficeBuilder: async ({ backOfficePage }, use) => {
    await use(
      new AxeBuilder({
        page: backOfficePage as unknown as ConstructorParameters<
          typeof AxeBuilder
        >[0]['page']
      }).withTags(accessibilityTags)
    )
  },

  // eslint-disable-next-line no-empty-pattern
  lisBackOfficeClient: async ({}, use) => {
    const apiContext = await request.newContext({
      baseURL: process.env.backOfficeUrl
    })
    const lisBackOfficeClient = new LisBackOfficeClient(
      apiContext,
      'lis-back-office'
    )
    await use(lisBackOfficeClient)
  },
  // eslint-disable-next-line no-empty-pattern
  lisFrontOfficeClient: async ({}, use) => {
    const apiContext = await request.newContext({})
    const lisFrontOfficeClient = new LisFrontOfficeClient(
      apiContext,
      'lis-front-office'
    )
    await use(lisFrontOfficeClient)
  },

  lisFrontOfficeHomePage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeHomePage(frontOfficePage))
  },

  lisBackOfficeHomePage: async ({ backOfficePage }, use) => {
    await use(new LisBackOfficeHomePage(backOfficePage))
  },

  lisBackOfficeIdentityPage: async ({ backOfficePage }, use) => {
    await use(new LisBackOfficeIdentityPage(backOfficePage))
  },

  lisFrontOfficeIdentityPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeIdentityPage(frontOfficePage))
  },

  lisFrontOfficeHoldingDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeHoldingsPage(frontOfficePage))
  },

  lisFrontOfficeAnimalsOnHoldingPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeAnimalsOnHoldingPage(frontOfficePage))
  },

  lisFrontOfficeCattleHoldingOverviewPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCattleHoldingOverviewPage(frontOfficePage))
  },

  lisFrontOfficeMyProfilePage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeMyProfilePage(frontOfficePage))
  },

  lisFrontOfficeCattleDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCattleDetailsPage(frontOfficePage))
  },

  lisFrontOfficeRegisterCalfDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeRegisterCalfDetailsPage(frontOfficePage))
  },

  lisFrontOfficeDamDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeDamDetailsPage(frontOfficePage))
  },

  lisFrontOfficeGeneticDamDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeGeneticDamDetailsPage(frontOfficePage))
  },

  lisFrontOfficeSurrogateDamDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeSurrogateDamDetailsPage(frontOfficePage))
  },

  lisFrontOfficeSireDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeSireDetailsPage(frontOfficePage))
  },

  lisFrontOfficeCheckCalfDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCheckCalfDetailsPage(frontOfficePage))
  },

  lisFrontOfficeSubmitCattleRegistrationPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeSubmitCattleRegistrationPage(frontOfficePage))
  },

  lisFrontOfficeRegisterNewCattleBirthPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeRegisterNewCattleBirthPage(frontOfficePage))
  },

  lisFrontOfficeRegisterCattleBirthPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeRegisterCattleBirthPage(frontOfficePage))
  },

  lisFrontOfficeCancelDraftRegistrationPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeCancelDraftRegistrationPage(frontOfficePage))
  },

  lisFrontOfficeCancelThisRegistrationPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeCancelThisRegistrationPage(frontOfficePage))
  },

  lisFrontOfficeSubmissionDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeSubmissionDetailsPage(frontOfficePage))
  },

  lisFrontOfficeMovementDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeMovementDetailsPage(frontOfficePage))
  },

  lisFrontOfficeCheckMovementDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCheckMovementDetailsPage(frontOfficePage))
  },

  lisFrontOfficeOnOrOffMovementPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeOnOrOffMovementPage(frontOfficePage))
  },

  lisFrontOfficeReportACattleMovementPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeReportACattleMovementPage(frontOfficePage))
  },

  lisFrontOfficeSubmitMovementReportPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeSubmitMovementReportPage(frontOfficePage))
  },

  lisFrontOfficeCheckAnimalDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCheckAnimalDetailsPage(frontOfficePage))
  },

  lisFrontOfficeIsTheAnimalRegisteredPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeIsTheAnimalRegisteredPage(frontOfficePage))
  },

  lisFrontOfficeAnimalDetailsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeAnimalDetailsPage(frontOfficePage))
  },

  lisFrontOfficeReportCattleDeathsPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeReportCattleDeathsPage(frontOfficePage))
  },

  lisFrontOfficeSubmitCattleDeathPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeSubmitCattleDeathPage(frontOfficePage))
  },

  lisFrontOfficeUnregisteredAnimalDetailsPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeUnregisteredAnimalDetailsPage(frontOfficePage))
  },

  lisFrontOfficeExportCattleDataPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeExportCattleDataPage(frontOfficePage))
  },

  lisFrontOfficeCattleErrorRecordDetailPage: async (
    { frontOfficePage },
    use
  ) => {
    await use(new LisFrontOfficeCattleErrorRecordDetailPage(frontOfficePage))
  },

  lisFrontOfficeCattleErrorRecordPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCattleErrorRecordPage(frontOfficePage))
  },

  lisFrontOfficeCattleOnHoldingPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficeCattleOnHoldingPage(frontOfficePage))
  },

  lisFrontOfficePendingValidationPage: async ({ frontOfficePage }, use) => {
    await use(new LisFrontOfficePendingValidationPage(frontOfficePage))
  }
})

export const { Given, When, Then } = createBdd(test)
