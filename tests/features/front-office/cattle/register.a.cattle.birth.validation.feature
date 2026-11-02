Feature: Cattle - Register a Cattle Birth - Validation

    Background:
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    Scenario: Empty field errors
        When I continue from Calf details
        Then I should see the errors:
            | Enter all or part of the animal ear tag number you are registering                                           |
            | Enter the date the animal was born                                                                           |
            | Select if the animal is male or female                                                                       |
            | Enter the animal breed or breed code into the text box and select the correct one from the suggested options |

    Scenario Outline: Date Of Birth errors - <case>
        When I enter calf details with "<earTag>", "<dob>", "<sex>", and "<breed>"
        Then I should see the error "<error>"

        Examples:
            | case                            | earTag         | dob        | sex    | breed           | error                                                     |
            | date of birth in future         | UK123456301550 | 1/1/2099   | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | date of birth is tomorrow       | UK123456301550 | tomorrow   | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | invalid date of birth in future | UK123456301550 | ABCDEFG    | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | US style date of birth          | UK123456301550 | 12/20/2025 | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | Non leap year                   | UK123456301550 | 29/02/2023 | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |

    Scenario: Max length errors
        When I enter 255 length strings into the fields and continue
        Then I should see the error "Maximum 64 characters"

    Scenario: Animal tag in an invalid format - no results found
        When I search for the animal ear tag "£$%^&&"
        Then I should see No results found message in the lookup

    Scenario: Animal tag in an valid format but doesnt exist - no results found
        When I search for the animal ear tag "UK000000000000"
        Then I should see No results found message in the lookup

    Scenario: Breed in an invalid format - no results found
        When I search for the Breed "£$%^&&"
        Then I should see No results found message in the lookup

    Scenario: Breed in an valid format but doesnt exist - no results found
        When I search for the Breed "Test (TEST)"
        Then I should see No results found message in the lookup

    Scenario: Date of birth more than 27 days in the past - late registration error
        When I enter calf details with "UK123456301550", "28 days ago", "Female", and "Danish Red (DR)"
        Then I should see the error "Date of birth is more than 27 days ago. This is a late registration"