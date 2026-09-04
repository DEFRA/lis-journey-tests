import { Given } from '../../fixtures/test.fixture'
import { expect } from '@playwright/test'

Given(
  /^the (.*) should be accessible$/,
  async ({ axeFrontOfficeBuilder, axeBackOfficeBuilder }, pageName: string) => {
    console.log(`Checking accessibility for ${pageName} ...`)
    const axeBuilder = pageName.includes('LIS Front Office')
      ? axeFrontOfficeBuilder
      : axeBackOfficeBuilder
    const results = await axeBuilder.analyze()

    expect(results.violations).toEqual([])
  }
)
