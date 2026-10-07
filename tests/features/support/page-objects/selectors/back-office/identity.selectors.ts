import type { TestEnv } from '../../../../../../configs/env'

type IdentitySelectors = {
  userDescriptionLabel: string
  userRoleLabel: string
  signInButton: string
  emailInput?: string
  passwordInput?: string
  nextButton?: string
}

const identitySelectorsByEnv: Record<TestEnv, IdentitySelectors> = {
  docker: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'input[value="Sign in"]',
    emailInput: 'input[type="email"]',
    passwordInput: 'input[type="password"]',
    nextButton: 'input[value="Next"]'
  },
  local: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'button:text("Sign in")',
    emailInput: 'input[type="email"]',
    passwordInput: 'input[type="password"]',
    nextButton: 'input[value="Next"]'
  },
  dev: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'input[value="Sign in"]',
    emailInput: 'input[type="email"]',
    passwordInput: 'input[type="password"]',
    nextButton: 'input[value="Next"]'
  },
  test: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'input[value="Sign in"]',
    emailInput: 'input[type="email"]',
    passwordInput: 'input[type="password"]',
    nextButton: 'input[value="Next"]'
  }
}

export function getIdentitySelectors(env: TestEnv): IdentitySelectors {
  return identitySelectorsByEnv[env]
}
