import type { TestEnv } from '../../../../../../configs/env'

type IdentitySelectors = {
  userDescriptionLabel: string
  userRoleLabel: string
  signInButton: string
  emailInput?: string
  passwordInput?: string
  continueButton?: string
}

const identitySelectorsByEnv: Record<TestEnv, IdentitySelectors> = {
  docker: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'button:text("Sign in")',
    emailInput: '#email',
    passwordInput: '#password',
    continueButton: 'Continue'
  },
  local: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'button:text("Sign in")'
  },
  dev: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'button:text("Sign in")',
    emailInput: '#email',
    passwordInput: '#password',
    continueButton: 'Continue'
  },
  test: {
    userDescriptionLabel: 'label[for="email"]',
    userRoleLabel: '#email-item-hint',
    signInButton: 'button:text("Sign in")',
    emailInput: '#email',
    passwordInput: '#password',
    continueButton: 'Continue'
  }
}

export function getIdentitySelectors(env: TestEnv): IdentitySelectors {
  return identitySelectorsByEnv[env]
}
