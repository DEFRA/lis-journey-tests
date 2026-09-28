export const fakeUsers = {
  standard: {
    email: 'joe.helpdesk@defra.gov.uk',
    name: 'Joe Helpdesk',
    hint: 'Standard back-office user'
  },
  noRole: {
    email: 'no.role@defra.gov.uk',
    name: 'No Role',
    hint: 'Corporate user with no assigned back-office role'
  },
  internal: {
    email: 'norman.o.robertson@defra.gov.uk',
    name: 'Norman O Robertson',
    hint: 'Internal test role'
  },
  singleCph: {
    email: 'defralivestock+oakfield@gmail.com',
    name: 'Oakfield Farmer',
    hint: 'User with a single holding'
  },
  multipleCph: {
    email: 'defralivestock+fairfield@gmail.com',
    name: 'Fairfield Farmer',
    hint: 'User with multiple holdings'
  },
  noCph: {
    email: 'defralivestock+noholdings@gmail.com',
    name: 'Test Farmer',
    hint: 'User with no linked holdings'
  }
}
