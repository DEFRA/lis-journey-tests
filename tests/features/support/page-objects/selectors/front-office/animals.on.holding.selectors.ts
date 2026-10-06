import type { TestEnv } from '../../../../../../configs/env'

type AnimalsOnHoldingSelectors = {
  navigationTab: string
  searchLabel: string
  searchHint: string
  searchInput: string
  searchInsetInfo: string
  nextPaginationLink: string
  previousPaginationLink: string
  searchButton: string
}

const animalsOnHoldingSelectorsByEnv: Record<
  TestEnv,
  AnimalsOnHoldingSelectors
> = {
  docker: {
    navigationTab: 'nav.lis-sub-navigation',
    searchLabel: 'label[for=search]',
    searchHint: '#search-hint',
    searchInput: '.lis-search-form input#search',
    searchInsetInfo: '.govuk-inset-text',
    nextPaginationLink: '.govuk-pagination__next a',
    previousPaginationLink: '.govuk-pagination__prev a',
    searchButton: '.lis-search-form__submit'
  },
  local: {
    navigationTab: 'nav.lis-sub-navigation',
    searchLabel: 'label[for=search]',
    searchHint: '#search-hint',
    searchInput: '.lis-search-form input#search',
    searchInsetInfo: '.govuk-inset-text',
    nextPaginationLink: '.govuk-pagination__next a',
    previousPaginationLink: '.govuk-pagination__prev a',
    searchButton: '.lis-search-form__submit'
  },
  dev: {
    navigationTab: 'nav.lis-sub-navigation',
    searchLabel: 'label[for=search]',
    searchHint: '#search-hint',
    searchInput: '.lis-search-form input#search',
    searchInsetInfo: '.govuk-inset-text',
    nextPaginationLink: '.govuk-pagination__next a',
    previousPaginationLink: '.govuk-pagination__prev a',
    searchButton: '.lis-search-form__submit'
  },
  test: {
    navigationTab: 'nav.lis-sub-navigation',
    searchLabel: 'label[for=search]',
    searchHint: '#search-hint',
    searchInput: '.lis-search-form input#search',
    searchInsetInfo: '.govuk-inset-text',
    nextPaginationLink: '.govuk-pagination__next a',
    previousPaginationLink: '.govuk-pagination__prev a',
    searchButton: '.lis-search-form__submit'
  }
}

export function getAnimalsOnHoldingSelectors(
  env: TestEnv
): AnimalsOnHoldingSelectors {
  return animalsOnHoldingSelectorsByEnv[env]
}
