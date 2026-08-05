import { request } from '@playwright/test'
import { test as base, createBdd } from 'playwright-bdd'
import { LisFrontOfficeClient } from '../features/support/api/lis.front.office.client'
import { LisBackOfficeClient } from '../features/support/api/lis.back.office.client'
import { LisFrontOfficeHomePage } from '../features/support/page-objects/front-office/home.page'
import { LisBackOfficeHomePage } from '../features/support/page-objects/back-office/home.page'
import AxeBuilder from '@axe-core/playwright'

export const test = base.extend<{
  lisFrontOfficeClient: LisFrontOfficeClient
  lisBackOfficeClient: LisBackOfficeClient
  lisFrontOfficeHomePage: LisFrontOfficeHomePage
  lisBackOfficeHomePage: LisBackOfficeHomePage
  axeBuilder: AxeBuilder
}>({
  axeBuilder: async ({ page }, use) => {
    const axeBuilder = new AxeBuilder({ page }).withTags([
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
      baseURL:
        process.env.CDP === undefined && process.env.ENVIRONMENT === 'dev'
          ? process.env.apiURLExt
          : process.env.apiURL
    })
    const lisBackOfficeClient = new LisBackOfficeClient(
      apiContext,
      'lis-back-office'
    )
    await use(lisBackOfficeClient)
  },
  // eslint-disable-next-line no-empty-pattern
  lisFrontOfficeClient: async ({}, use) => {
    const apiContext = await request.newContext({
      baseURL: process.env.uiURL
    })
    const lisFrontOfficeClient = new LisFrontOfficeClient(
      apiContext,
      'lis-front-office'
    )
    await use(lisFrontOfficeClient)
  },

  lisFrontOfficeHomePage: async ({ page }, use) => {
    const lisFrontOfficeHomePage = new LisFrontOfficeHomePage(page)
    await use(lisFrontOfficeHomePage)
  },

  lisBackOfficeHomePage: async ({ browser }, use) => {
    const context = await browser.newContext({
      baseURL:
        process.env.CDP === undefined && process.env.ENVIRONMENT === 'dev'
          ? process.env.apiURLExt
          : process.env.apiURL
    })
    const lisBackOfficeHomePage = new LisBackOfficeHomePage(
      await context.newPage()
    )
    await use(lisBackOfficeHomePage)
  }
})

const { AfterScenario } = createBdd(test)

AfterScenario(async ({ page }) => {
  await page.close()
})

export const { Given, When, Then } = createBdd(test)
