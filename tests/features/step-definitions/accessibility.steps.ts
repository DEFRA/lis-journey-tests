import { Given } from '../../fixtures/test.fixture'
import { expect } from '@playwright/test'

Given(
  /^the (.*) should be accessible$/,
  async ({ axeBuilder }, pageName: string) => {
    console.log(`Checking accessibility for ${pageName} page...`)
    const results = await axeBuilder.analyze()

    expect(results.violations).toEqual([])
  }
)
