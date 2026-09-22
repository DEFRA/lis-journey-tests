import type { TestEnv } from '../../../../../../configs/env'

type HomeSelectors = {
  speciesCards: string
}

const homeSelectorsByEnv: Record<TestEnv, HomeSelectors> = {
  docker: {
    speciesCards: 'ul.card-group'
  },
  local: {
    speciesCards: 'ul.card-group'
  },
  dev: {
    speciesCards: 'ul.card-group'
  },
  test: {
    speciesCards: 'ul.card-group'
  }
}

export function getHomeSelectors(env: TestEnv): HomeSelectors {
  return homeSelectorsByEnv[env]
}
