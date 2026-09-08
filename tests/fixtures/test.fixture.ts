import { request, Page } from '@playwright/test'
import { test as base, createBdd } from 'playwright-bdd'
import { LisFrontOfficeClient } from '../features/support/api/lis.front.office.client'
import { LisBackOfficeClient } from '../features/support/api/lis.back.office.client'
import { LisFrontOfficeHomePage } from '../features/support/page-objects/front-office/home.page'
import { LisBackOfficeHomePage } from '../features/support/page-objects/back-office/home.page'
import { LisBackOfficeIdentityPage } from '../features/support/page-objects/back-office/identity.page'
import AxeBuilder from '@axe-core/playwright'

export const test = base.extend<{
  lisFrontOfficeClient: LisFrontOfficeClient
  lisBackOfficeClient: LisBackOfficeClient
  lisFrontOfficeHomePage: LisFrontOfficeHomePage
  lisBackOfficeHomePage: LisBackOfficeHomePage
  lisBackOfficeIdentityPage: LisBackOfficeIdentityPage
  axeFrontOfficeBuilder: AxeBuilder
  axeBackOfficeBuilder: AxeBuilder
  frontOfficePage: Page
  backOfficePage: Page
}>({
  frontOfficePage: async ({ browser }, use) => {
    const context = await browser.newContext({})
    await use(await context.newPage())
  },

  backOfficePage: async ({ browser }, use) => {
    const context = await browser.newContext({
      baseURL: process.env.backOfficeUrl
    })
    await use(await context.newPage())
  },

  axeFrontOfficeBuilder: async ({ frontOfficePage }, use) => {
    const axeBuilder = new AxeBuilder({ page: frontOfficePage }).withTags([
      'wcag2a',
      'wcag2aa',
      'wcag21a',
      'wcag21aa'
    ])

    await use(axeBuilder)
  },

  axeBackOfficeBuilder: async ({ backOfficePage }, use) => {
    const axeBuilder = new AxeBuilder({ page: backOfficePage }).withTags([
      'wcag2a',
      'wcag2aa',
      'wcag21a',
      'wcag21aa'
    ])

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
  }
})

const { AfterScenario } = createBdd(test)

AfterScenario(async ({ page }) => {
  await page.close()
})

export const { Given, When, Then } = createBdd(test)
