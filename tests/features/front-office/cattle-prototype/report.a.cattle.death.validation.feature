Feature: Cattle - Report a Cattle Death - Validation

    Background: Sign in to the prototype and start Report a cattle death
        Given I log into the herokuapp mvp
        When I select Report a cattle death

    Scenario: Is the animal registered on your holding - Error shown when no option is selected
        And I continue from the "Is the animal registered on your holding?" page
        Then I should see the error "Select if the animal is already registered to your holding"

    Scenario: Registered Animal details - Errors shown when the ear tag and date of death are empty
        When I select "Yes" to is the animal registered
        And I continue from the "Animal details" page
        Then I should see the errors:
            | Enter all or part of the animal ear tag number you are reporting |
            | Enter the date the animal died                                   |

    #Lookup validation is not present in prototype, but added to test for future proofing
    @fixme
    Scenario Outline: Registered Animal details - <field> - <case> - no results found
        When I select "Yes" to is the animal registered
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                 | case                          | value          |
            | Animal ear tag number | invalid format                | £$%^&&         |
            | Animal ear tag number | valid format but doesnt exist | UK000000000000 |

    Scenario Outline: Registered Animal details - Date Of Death errors - <case>
        When I select "Yes" to is the animal registered
        When I submit tag "<earTag>" and date of death "<dod>"
        Then I should see the error "<error>"

        Examples:
            | case                      | earTag         | dod        | error                                                     |
            | date of death in future   | UK123456301550 | 1/1/2099   | Date of death needs to be in the past                     |
            | date of death is tomorrow | UK123456301550 | tomorrow   | Date of death needs to be in the past                     |
            | US style date of death    | UK123456301550 | 12/20/2025 | Date of death must be a real date, for example 01/05/2026 |
            | Non leap year             | UK123456301550 | 29/02/2023 | Date of death must be a real date, for example 01/05/2026 |

        @fixme
        # Invalid date of death validation is not present in prototype, but added to test for future proofing
        Examples:
            | case                  | earTag         | dod     | error                                                     |
            | invalid date of death | UK123456301550 | ABCDEFG | Date of death must be a real date, for example 01/05/2026 |

    #Max length validation not present in prototype, but added to test for future proofing
    @fixme
    Scenario: Registered Animal details page - Max length validation
        When I select "Yes" to is the animal registered
        When I enter 255 characters into the "Animal ear tag number" field
        When I enter 255 characters into the "Date of death" field
        And I continue from the "Animal details" page
        Then the "Animal ear tag number" field shows the error "Maximum 64 characters"
        Then the "Date of death" field shows the error "Maximum 64 characters"

    Scenario: Unregistered Animal details - Errors shown when all fields are empty
        When I select "No" to is the animal registered
        And I continue from the "Animal details" page
        Then I should see the errors:
            | Enter the animal ear tag number you are reporting                                                            |
            | Enter the date the animal was born                                                                           |
            | Enter the date the animal died                                                                               |
            | Select if the animal is male or female                                                                       |
            | Enter the animal breed or breed code into the text box and select the correct one from the suggested options |

    #Lookup validation is not present in prototype, but added to test for future proofing
    @fixme
    Scenario Outline: Unregistered Animal details - <field> - <case> - no results found
        When I select "No" to is the animal registered
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                 | case                          | value          |
            | Animal ear tag number | invalid format                | £$%^&&         |
            | Animal ear tag number | valid format but doesnt exist | UK000000000000 |

    Scenario Outline: Unregistered Animal details - Date Of Death errors - <case>
        When I select "No" to is the animal registered
        And I submit valid animal details with "<earTag>", "<dob>","<dod>", "<sex>", and "<breed>"
        Then I should see the error "<error>"

        Examples:
            | case                      | earTag         | dob        | dod        | sex    | breed          | error                                                     |
            | date of death in future   | UK123456301550 | 01/01/2025 | 1/1/2099   | Female | Limousin (LIM) | Date of death needs to be in the past                     |
            | date of death is tomorrow | UK123456301550 | 01/01/2025 | tomorrow   | Female | Limousin (LIM) | Date of death needs to be in the past                     |
            | US style date of death    | UK123456301550 | 01/01/2025 | 12/20/2025 | Female | Limousin (LIM) | Date of death must be a real date, for example 01/05/2026 |
            | Non leap year             | UK123456301550 | 01/01/2025 | 29/02/2026 | Female | Limousin (LIM) | Date of death must be a real date, for example 01/05/2026 |
            | Death before birth date   | UK123456301550 | 01/01/2025 | 22/02/2023 | Female | Limousin (LIM) | Date of death cannot be before the date of birth          |

        @fixme
        # Invalid date of death validation is not present in prototype, but added to test for future proofing
        Examples:
            | case                  | earTag         | dob        | dod     | sex  | breed          | error                                                     |
            | invalid date of death | UK123456301550 | 01/01/2025 | ABCDEFG | Male | Limousin (LIM) | Date of death must be a real date, for example 01/05/2026 |

    # Checks only the Date of birth error, as a future birth date may also trigger the date of death error
    Scenario Outline: Unregistered Animal details - Date Of Birth errors - <case>
        When I select "No" to is the animal registered
        And I submit valid animal details with "<earTag>", "<dob>","<dod>", "<sex>", and "<breed>"
        Then the "Date of birth" field shows the error "<error>"

        Examples:
            | case                      | earTag         | dob        | dod   | sex    | breed          | error                                                     |
            | date of birth in future   | UK123456301550 | 1/1/2099   | today | Female | Limousin (LIM) | Date of birth must be today or in the past                |
            | date of birth is tomorrow | UK123456301550 | tomorrow   | today | Female | Limousin (LIM) | Date of birth must be today or in the past                |
            | invalid date of birth     | UK123456301550 | ABCDEFG    | today | Female | Limousin (LIM) | Date of birth must be a real date, for example 01/05/2026 |
            | US style date of birth    | UK123456301550 | 12/20/2025 | today | Female | Limousin (LIM) | Date of birth must be a real date, for example 01/05/2026 |
            | Non leap year             | UK123456301550 | 29/02/2023 | today | Female | Limousin (LIM) | Date of birth must be a real date, for example 01/05/2026 |

    Scenario Outline: Unregistered Animal details - Breed - <case> - no results found
        When I select "No" to is the animal registered
        When I search for "<value>" in the "Breed" field
        Then the "Breed" field shows No results found

        Examples:
            | case                          | value       |
            | invalid format                | £$%^&&      |
            | valid format but doesnt exist | Test (TEST) |

    #Max length validation not present in prototype, but added to test for future proofing
    @fixme
    Scenario: Unregistered Animal details page - Max length validation
        When I select "No" to is the animal registered
        When I enter 255 characters into the "Animal ear tag number" field
        When I enter 255 characters into the "Date of death" field
        And I continue from the "Animal details" page
        Then the "Animal ear tag number" field shows the error "Maximum 64 characters"
        Then the "Date of death" field shows the error "Maximum 64 characters"

    Scenario: Report cattle deaths - Error shown when add more deaths is not answered
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        And I continue from the "Check animal details" page
        And I continue from the "Report cattle deaths" page
        Then I should see the errors:
            | Select yes to report more deaths, or no to continue |

    Scenario: Report cattle deaths - Answering No to add more deaths shows the add at least one animal error
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        And I submit "No" for add more animals for deaths
        And I continue from the "Report cattle deaths" page
        Then I should see the summary error "Add at least one animal before continuing"
    # Ear tag formats from the BA. The validation is in the next release, so remove @fixme then.
    # The ear tags are the BA's examples: replace them with the test data given with the release.
    # - EU imports keep their original ear tag (non-EU imports are given new UK ear tags)
    # - Pre-June 2000 UK ear tags were alphanumeric, e.g. UK AB1234 00123. They aren't issued any
    #   more, but legacy ear tags are still in the systems and must be accepted
    # Registered animals need animals with these ear tags on the holding in the test data
    @fixme
    Scenario Outline: Registered Animal details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        When I select "Yes" to is the animal registered
        When I submit tag "<earTag>" and date of death "today"
        Then I am on the "Check animal details" page

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |

    @fixme
    Scenario Outline: Unregistered Animal details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        When I select "No" to is the animal registered
        And I submit valid animal details with "<earTag>", "01/01/2025","today", "Female", and "Limousin (LIM)"
        Then I am on the "Check animal details" page

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |
