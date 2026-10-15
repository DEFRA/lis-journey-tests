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
import { LisFrontOfficeCattleDetailsPage } from '../page-objects/front-office/cattle.details.page'
import AxeBuilder from '@axe-core/playwright'

export const test = base.extend<{
  lisFrontOfficeClient: LisFrontOfficeClient
  lisBackOfficeClient: LisBackOfficeClient
  lisFrontOfficeHomePage: LisFrontOfficeHomePage
  lisBackOfficeHomePage: LisBackOfficeHomePage
  lisBackOfficeIdentityPage: LisBackOfficeIdentityPage
  lisFrontOfficeIdentityPage: LisFrontOfficeIdentityPage
  lisFrontOfficeHoldingDetailsPage: LisFrontOfficeHoldingsPage
  lisFrontOfficeAnimalsOnHoldingPage: LisFrontOfficeAnimalsOnHoldingPage
  lisFrontOfficeCattleDetailsPage: LisFrontOfficeCattleDetailsPage
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
    const axeBuilder = new AxeBuilder({
      page: frontOfficePage as unknown as ConstructorParameters<
        typeof AxeBuilder
      >[0]['page']
    }).withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])

    await use(axeBuilder)
  },

  axeBackOfficeBuilder: async ({ backOfficePage }, use) => {
    const axeBuilder = new AxeBuilder({
      page: backOfficePage as unknown as ConstructorParameters<
        typeof AxeBuilder
      >[0]['page']
    }).withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])

    await use(axeBuilder)
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
    const lisFrontOfficeHomePage = new LisFrontOfficeHomePage(frontOfficePage)
    await use(lisFrontOfficeHomePage)
  },

  lisBackOfficeHomePage: async ({ backOfficePage }, use) => {
    const lisBackOfficeHomePage = new LisBackOfficeHomePage(backOfficePage)
    await use(lisBackOfficeHomePage)
  },

  lisBackOfficeIdentityPage: async ({ backOfficePage }, use) => {
    const lisBackOfficeIdentityPage = new LisBackOfficeIdentityPage(
      backOfficePage
    )
    await use(lisBackOfficeIdentityPage)
  },

  lisFrontOfficeIdentityPage: async ({ frontOfficePage }, use) => {
    const lisFrontOfficeIdentityPage = new LisFrontOfficeIdentityPage(
      frontOfficePage
    )
    await use(lisFrontOfficeIdentityPage)
  },

  lisFrontOfficeHoldingDetailsPage: async ({ frontOfficePage }, use) => {
    const lisFrontOfficeHoldingDetailsPage = new LisFrontOfficeHoldingsPage(
      frontOfficePage
    )
    await use(lisFrontOfficeHoldingDetailsPage)
  },

  lisFrontOfficeAnimalsOnHoldingPage: async ({ frontOfficePage }, use) => {
    const lisFrontOfficeAnimalsOnHoldingPage =
      new LisFrontOfficeAnimalsOnHoldingPage(frontOfficePage)
    await use(lisFrontOfficeAnimalsOnHoldingPage)
  },

  lisFrontOfficeCattleDetailsPage: async ({ frontOfficePage }, use) => {
    const lisFrontOfficeCattleDetailsPage = new LisFrontOfficeCattleDetailsPage(
      frontOfficePage
    )
    await use(lisFrontOfficeCattleDetailsPage)
  }
})

export const { Given, When, Then } = createBdd(test)
