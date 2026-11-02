Feature: Cattle - Report a Cattle Death - Date pickers

    # Registered animals (Yes) only have a Date of death field.
    # Unregistered animals (No) have both Date of birth and Date of death fields.
    Background:
        Given I log into the herokuapp mvp
        When I select Report a cattle death

    Scenario Outline: Select todays date from the <field> date picker - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I select "today" from the "<field>" date picker
        Then the "<field>" field shows "today"

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario Outline: Select a date from a previous month in the <field> date picker - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I select "40 days ago" from the "<field>" date picker
        Then the "<field>" field shows "40 days ago"

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario Outline: Todays date is highlighted in the <field> date picker - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I open the "<field>" date picker
        Then "today" is shown as today in the "<field>" date picker

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario Outline: Future dates cannot be selected in the <field> date picker - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I open the "<field>" date picker
        Then "tomorrow" is unavailable in the "<field>" date picker

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario Outline: Closing the <field> date picker keeps the date already entered - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I type "11/2/2025" into the "<field>" field
        And I open the "<field>" date picker
        And I close the "<field>" date picker
        Then the "<field>" field shows "11/2/2025"

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario Outline: The <field> date picker opens on the date already entered - animal registered: <registered>
        When I select "<registered>" to is the animal registered
        And I type "11/2/2025" into the "<field>" field
        And I open the "<field>" date picker
        Then "11/2/2025" is selected in the "<field>" date picker

        Examples:
            | registered | field         |
            | Yes        | Date of death |
            | No         | Date of birth |
            | No         | Date of death |

    Scenario: Each date picker only fills its own field - animal registered: No
        When I select "No" to is the animal registered
        And I select "today" from the "Date of death" date picker
        Then the "Date of death" field shows "today"
        And the "Date of birth" field shows ""