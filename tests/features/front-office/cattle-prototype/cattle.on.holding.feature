Feature: Cattle - Cattle on holding - Positive scenarios

    Background: Sign in to the prototype and open Cattle on holding
        Given I log into the herokuapp mvp
        When I select "Cattle on holding" on the holding overview
        Then I should see the heading "Cattle on holding"

    Scenario Outline: Verify the Cattle on holding table sorts by <column>
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<firstClick>" order
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<secondClick>" order

        # Ear tag number is already sorted ascending when the page loads, so the first click flips it
        Examples:
            | column          | firstClick | secondClick |
            | Ear tag number  | descending | ascending   |
            | Date of birth   | ascending  | descending  |
            | Age             | ascending  | descending  |
            | Date on holding | ascending  | descending  |
            | Sex             | ascending  | descending  |
            | Breed           | ascending  | descending  |
