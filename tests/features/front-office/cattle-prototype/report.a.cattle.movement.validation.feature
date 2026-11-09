Feature: Cattle - Report a Cattle Movement - Negative scenarios

    Background: Sign in to the prototype and start Report a cattle movement
        Given I log into the herokuapp mvp
        When I select Report a cattle movement

    Scenario: Select movement type - Error shown when no movement type is selected
        When I continue from the "Select movement type" page
        Then I should see the errors:
            | Select if this is an on or off movement |

    Scenario: Movement details - On movement - Error shown when no ear tag is entered
        When I select "On movement" and continue
        When I continue from the "Movement details" page
        Then I should see the errors:
            | Enter at least one ear tag number |

    Scenario: Movement details - Off movement - Error shown when no ear tag is entered
        When I select "Off movement" and continue
        When I continue from the "Movement details" page
        Then I should see the errors:
            | Enter at least one ear tag number |

    Scenario Outline: Movement details - <movementType> - Ear tag number - <case> - no results found
        When I select "<movementType>" and continue
        When I submit movement details
            | Ear tag number | Movement date   |
            | <value>        | <movement date> |
        Then the "Ear tag number for animal 1" field shows No results found

        Examples:
            | movementType | case                          | movement date | value          |
            | Off movement | invalid format                | 01/01/2025    | £$%^&&         |
            | Off movement | valid format but doesnt exist | 01/01/2025    | UK000000000000 |

        # No tag validation on the prototype, for On Movement, but added to test for future proofing
        @fixme
        Examples:
            | movementType | case                          | movement date | value          |
            | On movement  | invalid format                | 01/01/2025    | £$%^&&         |
            | On movement  | valid format but doesnt exist | 01/01/2025    | UK000000000000 |

    Scenario Outline: Movement details - <movementType> - Movement date errors - <case>
        When I select "<movementType>" and continue
        When I submit movement details
            | Ear tag number | Movement date   |
            | <value>        | <movement date> |
        Then I should see the error "<error>"

        Examples:
            | movementType | case                      | value          | movement date | error                                                                 |
            | On movement  | movement date in future   | UK123456301550 | 1/1/2099      | Movement date for animal 1 must be today or in the past               |
            | On movement  | movement date is tomorrow | UK123456301550 | tomorrow      | Movement date for animal 1 must be today or in the past               |
            | On movement  | US style movement date    | UK123456301550 | 12/20/2025    | Movement date for animal 1 must be a real date, for example 27/3/2026 |
            | On movement  | Non leap year             | UK123456301550 | 29/02/2023    | Movement date for animal 1 must be a real date, for example 27/3/2026 |
            | On movement  | Invalid format            | UK123456301550 | ABCDEFG       | Movement date for animal 1 must be a real date, for example 27/3/2026 |
            | Off movement | movement date in future   | UK324537113235 | 1/1/2099      | Movement date for animal 1 must be today or in the past               |
            | Off movement | movement date is tomorrow | UK324537113235 | tomorrow      | Movement date for animal 1 must be today or in the past               |
            | Off movement | US style movement date    | UK324537113235 | 12/20/2025    | Movement date for animal 1 must be a real date, for example 27/3/2026 |
            | Off movement | Non leap year             | UK324537113235 | 29/02/2023    | Movement date for animal 1 must be a real date, for example 27/3/2026 |
            | Off movement | Invalid format            | UK324537113235 | ABCDEFG       | Movement date for animal 1 must be a real date, for example 27/3/2026 |

    Scenario Outline: Movement details - <movementType> - Incomplete animal - <case>
        When I select "<movementType>" and continue
        When I submit movement details
            | Ear tag number | Movement date   |
            | <value>        | <movement date> |
        Then I should see the error "<error>"

        Examples:
            | movementType | case                | value          | movement date | error                                 |
            | On movement  | ear tag but no date | UK123456301550 |               | Enter the movement date for animal 1  |
            | On movement  | date but no ear tag |                | 01/01/2025    | Enter the ear tag number for animal 1 |
            | Off movement | ear tag but no date | UK324537113235 |               | Enter the movement date for animal 1  |
            | Off movement | date but no ear tag |                | 01/01/2025    | Enter the ear tag number for animal 1 |

    Scenario: Movement details - Future movement date on the second animal shows an error for animal 2
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301551 | 1/1/2099      |
        Then I should see the error "Movement date for animal 2 must be today or in the past"

    Scenario: Movement details - Error shown when the same ear tag is entered for two animals
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301550 | 01/01/2025    |
        Then I should see the error "The ear tag number for animal 2 has already been added to this movement"

    # Reporting deadline not present in prototype, number of days and error message to be confirmed against the story
    @fixme
    Scenario: Movement details - Error shown when the movement date is too far in the past
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 1/1/2000      |
        Then I should see the error "Movement date for animal 1 is too far in the past"

    # Max length validation not present in prototype, but added to test for future proofing
    @fixme
    Scenario: Movement details - Ear tag number - Max length validation
        When I select "On movement" and continue
        When I enter 255 characters into the "Ear tag number for animal 1" field
        And I continue from the "Movement details" page
        Then the "Ear tag number for animal 1" field shows the error "Maximum 64 characters"

    # Hard limit not set in prototype
    @fixme
    Scenario: Movement details - Error shown when more than 20 animals are added
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301551 | 01/01/2025    |
            | UK123456301552 | 01/01/2025    |
            | UK123456301553 | 01/01/2025    |
            | UK123456301554 | 01/01/2025    |
            | UK123456301555 | 01/01/2025    |
            | UK123456301556 | 01/01/2025    |
            | UK123456301557 | 01/01/2025    |
            | UK123456301558 | 01/01/2025    |
            | UK123456301559 | 01/01/2025    |
            | UK123456301560 | 01/01/2025    |
            | UK123456301561 | 01/01/2025    |
            | UK123456301562 | 01/01/2025    |
            | UK123456301563 | 01/01/2025    |
            | UK123456301564 | 01/01/2025    |
            | UK123456301565 | 01/01/2025    |
            | UK123456301566 | 01/01/2025    |
            | UK123456301567 | 01/01/2025    |
            | UK123456301568 | 01/01/2025    |
            | UK123456301569 | 01/01/2025    |
            | UK123456301570 | 01/01/2025    |
        Then I should see the error "You can only add a maximum of 20 animals"

