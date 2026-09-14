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
    email: 'oakfield.farmer@oakhill-farms.co.uk',
    name: 'Oakfield Farmer',
    hint: 'User with a single holding'
  },
  multipleCph: {
    email: 'fairfield.farmer@fairfield-farms.co.uk',
    name: 'Fairfield Farmer',
    hint: 'User with multiple holdings'
  },
  noCph: {
    email: 'farmer@example.com',
    name: 'Test Farmer',
    hint: 'User with no linked holdings'
  }
}
