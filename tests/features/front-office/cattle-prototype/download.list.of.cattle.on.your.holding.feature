Feature: Cattle - Download a list of cattle on your holding - Positive scenarios

    Background: Sign in to the prototype and open Download a list of cattle on your holding
        Given I log into the herokuapp mvp
        When I select Download a list of cattle on your holding

    Scenario: Request an export with all columns selected
        When I select all columns
        When I select Download
        Then I verify a download has been requested

    Scenario: Verify each column can be selected and deselected
        When I verify each column can be selected and deselected

    Scenario: Verify only the default columns are selected when the page opens
        Then I verify the default column selections

    Scenario: Request an export with a single column selected
        When I clear the default options
        When I select only the "Breed name" column
        And I select Download
        Then I verify a download has been requested

    Scenario: Request an export with multiple columns selected
        When I clear the default options
        When I select only the "Dam type" and "Sire name" columns
        And I select Download
        Then I verify a download has been requested

    Scenario: Request an export with default options without a date range
        When I Download default options
        Then I verify a download has been requested

    Scenario: Request an export with default options and a valid date range
        When I enter the date range from "1/1/2026" to "3/3/2026"
        And I select Download
        Then I verify a download has been requested

    Scenario: Request an export in CSV format with no date range
        When I select "CSV" as file format
        And I select Download
        Then I verify a download has been requested

    Scenario: Request an export in XLSX format with no date range
        When I select "XLSX" as file format
        When I Download default options
        Then I verify a download has been requested

    Scenario: Request an export in PDF format with no date range
        When I select "PDF" as file format
        When I Download default options
        Then I verify a download has been requested

    Scenario: Request an export in XLSX format with a date range
        When I select "XLSX" as file format
        When I enter the date range from "1/1/2026" to "3/3/2026"
        When I select Download
        Then I verify a download has been requested

    Scenario: Request an export in PDF format with a date range
        When I select "PDF" as file format
        When I enter the date range from "1/1/2026" to "3/3/2026"
        When I select Download
        Then I verify a download has been requested

    Scenario: Request an export with todays date as the date range
        When I enter the date range from "today" to "today"
        And I select Download
        Then I verify a download has been requested