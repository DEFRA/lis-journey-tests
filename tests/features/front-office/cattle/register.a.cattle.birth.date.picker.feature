Feature: Cattle - Register a Cattle Birth - Date of birth date picker

    Background:
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    Scenario: Select todays date from the date picker
        When I select "today" from the "Date of birth" date picker
        Then the "Date of birth" field shows "today"

    Scenario: Select a date from a previous month in the date picker
        When I select "40 days ago" from the "Date of birth" date picker
        Then the "Date of birth" field shows "40 days ago"

    Scenario: Todays date is highlighted in the date picker
        When I open the "Date of birth" date picker
        Then "today" is shown as today in the "Date of birth" date picker

    Scenario: Future dates cannot be selected in the date picker
        When I open the "Date of birth" date picker
        Then "tomorrow" is unavailable in the "Date of birth" date picker

    Scenario: Closing the date picker keeps the date already entered
        When I type "11/2/2025" into the "Date of birth" field
        And I open the "Date of birth" date picker
        And I close the "Date of birth" date picker
        Then the "Date of birth" field shows "11/2/2025"

    Scenario: The date picker opens on the date already entered
        When I type "11/2/2025" into the "Date of birth" field
        And I open the "Date of birth" date picker
        Then "11/2/2025" is selected in the "Date of birth" date picker