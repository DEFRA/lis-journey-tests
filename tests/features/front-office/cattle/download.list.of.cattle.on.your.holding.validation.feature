Feature: Cattle -  Download a list of cattle on your holding - Negative scenarios

    Background: Background name: Report a cattle movement
        Given I log into the herokuapp mvp
        When I select Download a list of cattle on your holding

    # Prototype downloads an empty report instead
    @fixme
    Scenario: Deselect all columns and download
        When I clear the default options
        And I select Download
        Then I should see the error "Select at least one column to include in the report"

    # No date validation on the prototype, but added to test for future proofing
    @fixme
    Scenario Outline: Date range - <case>
        When I enter the date range from "<from>" to "<to>"
        And I select Download
        Then the "<field>" field shows the error "<error>"

        Examples:
            | case                         | from       | to         | field | error                                                |
            | from date in the future      | 1/1/2099   | today      | From  | From date must be today or in the past               |
            | from date is tomorrow        | tomorrow   | tomorrow   | From  | From date must be today or in the past               |
            | to date in the future        | 1/1/2026   | 1/1/2099   | To    | To date must be today or in the past                 |
            | to date before the from date | 3/3/2026   | 1/1/2026   | To    | To date must be the same as or after the from date   |
            | invalid from date            | ABCDEFG    | 3/3/2026   | From  | From date must be a real date, for example 27/3/2026 |
            | invalid to date              | 1/1/2026   | ABCDEFG    | To    | To date must be a real date, for example 27/3/2026   |
            | US style from date           | 12/20/2025 | 3/3/2026   | From  | From date must be a real date, for example 27/3/2026 |
            | non leap year to date        | 1/1/2023   | 29/02/2023 | To    | To date must be a real date, for example 27/3/2026   |

        # Remove these if the story allows an open-ended date range
        Examples: Only one date entered
            | case                | from     | to       | field | error             |
            | from date but no to | 1/1/2026 |          | To    | Enter a to date   |
            | to date but no from |          | 3/3/2026 | From  | Enter a from date |
