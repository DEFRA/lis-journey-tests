Feature: Cattle - Register a Cattle Birth - Date of birth date picker

    Background:
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    @LREG-781
    Scenario: Select todays date from the date picker
        When I select "today" from the "Date of birth" date picker
        Then the "Date of birth" field shows "today"

    @LREG-781
    Scenario: Select a date from a previous month in the date picker
        When I select "40 days ago" from the "Date of birth" date picker
        Then the "Date of birth" field shows "40 days ago"

    @LREG-781
    Scenario: Todays date is highlighted in the date picker
        When I open the "Date of birth" date picker
        Then "today" is shown as today in the "Date of birth" date picker

    @LREG-781
    Scenario: Future dates cannot be selected in the date picker
        When I open the "Date of birth" date picker
        Then "tomorrow" is unavailable in the "Date of birth" date picker

    @LREG-781
    Scenario: Closing the date picker keeps the date already entered
        When I type "11/2/2025" into the "Date of birth" field
        And I open the "Date of birth" date picker
        And I close the "Date of birth" date picker
        Then the "Date of birth" field shows "11/2/2025"

    @LREG-781
    Scenario: The date picker opens on the date already entered
        When I type "11/2/2025" into the "Date of birth" field
        And I open the "Date of birth" date picker
        Then "11/2/2025" is selected in the "Date of birth" date picker

    @LREG-781
    Scenario Outline: Opening the date picker with the <key> key moves focus into the calendar
        When I tab to the "Date of birth" date picker button
        And I press "<key>"
        Then "today" has focus in the "Date of birth" date picker

        Examples:
            | key   |
            | Enter |
            | Space |

    @LREG-781
    Scenario Outline: Selecting a date using only the keyboard - <key>
        When I tab to the "Date of birth" date picker button
        And I press "Enter"
        And I press "<key>"
        Then "<date>" has focus in the "Date of birth" date picker
        When I press "Enter"
        Then the "Date of birth" date picker is closed
        And the "Date of birth" field shows "<date>"

        Examples:
            | key       | date       |
            | ArrowLeft | yesterday  |
            | ArrowUp   | 7 days ago |

    @LREG-781
    Scenario: Closing the date picker with the Escape key
        When I tab to the "Date of birth" date picker button
        And I press "Enter"
        And I press "Escape"
        Then the "Date of birth" date picker is closed
        And the "Date of birth" date picker button has focus
        And the "Date of birth" field shows ""