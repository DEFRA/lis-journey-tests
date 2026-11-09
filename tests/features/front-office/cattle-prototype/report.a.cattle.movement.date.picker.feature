Feature: Cattle - Report a Cattle Movement - Movement date date picker

    Background: Sign in to the prototype and start Report a cattle movement
        Given I log into the herokuapp mvp
        When I select Report a cattle movement

    Scenario Outline: Select todays date from the date picker - <movementType>
        When I select "<movementType>" and continue
        And I select "today" from the "Movement date" date picker
        Then the "Movement date" field shows "today"

        Examples:
            | movementType |
            | On movement  |
            | Off movement |

    Scenario Outline: Select a date from a previous month in the date picker - <movementType>
        When I select "<movementType>" and continue
        And I select "40 days ago" from the "Movement date" date picker
        Then the "Movement date" field shows "40 days ago"

        Examples:
            | movementType |
            | On movement  |
            | Off movement |

    Scenario Outline: Todays date is highlighted in the date picker - <movementType>
        When I select "<movementType>" and continue
        And I open the "Movement date" date picker
        Then "today" is shown as today in the "Movement date" date picker

        Examples:
            | movementType |
            | On movement  |
            | Off movement |

    Scenario Outline: Closing the date picker keeps the date already entered - <movementType>
        When I select "<movementType>" and continue
        And I type "11/2/2025" into the "Movement date" field
        And I open the "Movement date" date picker
        And I close the "Movement date" date picker
        Then the "Movement date" field shows "11/2/2025"

        Examples:
            | movementType |
            | On movement  |
            | Off movement |

    Scenario Outline: The date picker opens on the date already entered - <movementType>
        When I select "<movementType>" and continue
        And I type "11/2/2025" into the "Movement date" field
        And I open the "Movement date" date picker
        Then "11/2/2025" is selected in the "Movement date" date picker

        Examples:
            | movementType |
            | On movement  |
            | Off movement |