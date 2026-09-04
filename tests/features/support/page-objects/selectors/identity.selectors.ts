import type { TestEnv } from '../../../../../configs/env'

type IdentitySelectors = {
  userDescriptionLabel: string
  userRoleLabel: string
  signInButton: string
}

const identitySelectorsByEnv: Record<TestEnv, IdentitySelectors> = {
  docker: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'Sign in'
  },
  local: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'Sign in'
  },
  dev: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'Sign in'
  },
  test: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'Sign in'
  }
}

export function getIdentitySelectors(env: TestEnv): IdentitySelectors {
  return identitySelectorsByEnv[env]
}
