import type { TestEnv } from '../../../../../../configs/env'

type HoldingsSelectors = {
  navigationTab: string
}

const holdingsSelectorsByEnv: Record<TestEnv, HoldingsSelectors> = {
  docker: {
    navigationTab: 'nav.lis-sub-navigation'
  },
  local: {
    navigationTab: 'nav.lis-sub-navigation'
  },
  dev: {
    navigationTab: 'nav.lis-sub-navigation'
  },
  test: {
    navigationTab: 'nav.lis-sub-navigation'
  }
}

export function getHoldingsSelectors(env: TestEnv): HoldingsSelectors {
  return holdingsSelectorsByEnv[env]
}
