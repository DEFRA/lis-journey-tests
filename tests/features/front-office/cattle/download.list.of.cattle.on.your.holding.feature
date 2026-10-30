Feature: Cattle -  Download a list of cattle on your holding - Positive scenarios

    Background: Background name: Report a cattle movement
        Given I log into the herokuapp mvp
        When I select Download a list of cattle on your holding

    Scenario: Select all columns and download
        When I select all columns
        When I select Download
        Then I verify a download has been requested

    Scenario: Verify each column can be selected and deselected
        When I verify each column can be selected and deselected

    Scenario: Verify default column selections
        Then I verify the default column selections

    Scenario: Verify a single column can be selected and download report
        When I clear the default options
        # When I select only the "Breed name" column
        # And I select Download
        # Then I verify a download has been requested

    Scenario: Verify multiple columns can be selected and download report
        When I clear the default options
        When I select only the "Dam type" and "Sire name" columns
        # And I select Download
        # Then I verify a download has been requested

    Scenario: Request an export with default options without a date range
        When I Download default options
        Then I verify a download has been requested

    Scenario: Request an export default options with a valid date range
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