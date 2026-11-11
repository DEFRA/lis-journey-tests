Feature: Cattle - Register a Cattle Birth - Validation

    Background: Sign in to the prototype and start Register a cattle birth
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    @LREG-781
    Scenario: Calf Details - Empty field errors
        When I continue from the "Calf details" page
        Then I should see the errors:
            | Enter all or part of the animal ear tag number you are registering                                           |
            | Enter the date the animal was born                                                                           |
            | Select if the animal is male or female                                                                       |
            | Enter the animal breed or breed code into the text box and select the correct one from the suggested options |

    @LREG-781
    Scenario Outline: Calf Details - Date Of Birth errors - <case>
        When I enter calf details with "<earTag>", "<dob>", "<sex>", and "<breed>"
        Then I should see the error "<error>"

        Examples:
            | case                            | earTag         | dob        | sex    | breed           | error                                                     |
            | date of birth in future         | UK123456301550 | 1/1/2099   | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | date of birth is tomorrow       | UK123456301550 | tomorrow   | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | invalid date of birth in future | UK123456301550 | ABCDEFG    | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | US style date of birth          | UK123456301550 | 12/20/2025 | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | Non leap year                   | UK123456301550 | 29/02/2023 | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |

    @LREG-781
    #Max length errors not on prototype so this will fail
    @fixme
    Scenario Outline: Calf Details - Max length errors - <field>
        When I enter 255 characters into the "<field>" field
        And I continue from the "Calf details" page
        Then the "<field>" field shows the error "Maximum 64 characters"

        Examples:
            | field                 |
            | Animal ear tag number |
            | Breed                 |

    @LREG-781
    Scenario Outline: Calf Details - <field> - <case> - no results found
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                 | case                          | value          |
            | Animal ear tag number | invalid format                | £$%^&&         |
            | Animal ear tag number | valid format but doesnt exist | UK000000000000 |
            | Breed                 | invalid format                | £$%^&&         |
            | Breed                 | valid format but doesnt exist | Test (TEST)    |

    @LREG-781
    Scenario Outline: Calf Details - <field> - search using <case> '<searchTerm>' - matching tags are suggested
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        And the "<field>" field shows no more than 10 suggestions
        Examples: Partial and full ear tags
            | field                 | case          | searchTerm     | suggestion     |
            | Animal ear tag number | last 3 digits | 550            | UK123456301550 |
            | Animal ear tag number | herd mark     | 123456         | UK123456301550 |
            | Animal ear tag number | full ear tag  | UK123456301550 | UK123456301550 |

    @LREG-781
    Scenario Outline: Calf Details - Breed - search using <case> '<searchTerm>' - matching breeds are suggested
        When I search for "<searchTerm>" in the "Breed" field
        Then the "Breed" field suggests "<suggestion>"
        And every suggestion in the "Breed" field contains "<searchTerm>"
        Examples: Partial breed names and breed codes
            | case            | searchTerm | suggestion      |
            | breed code      | DR         | Danish Red (DR) |
            | first 3 letters | Dan        | Danish Red (DR) |

    @LREG-781
    Scenario: Calf Details - Date of birth more than 27 days in the past - late registration error
        When I enter calf details with "UK123456301550", "28 days ago", "Female", and "Danish Red (DR)"
        Then I should see the error "Date of birth is more than 27 days ago. This is a late registration"

    @LREG-782
    Scenario: Dam Details - Empty field errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        When I continue from the "Dam details" page
        Then I should see the errors:
            | Select if the calf was born via a genetic or surrogate dam |

    @LREG-783
    Scenario: Genetic Dam Details - Empty field errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I continue from the "Genetic dam details" page
        Then I should see the errors:
            | Enter all or part of the genetic dam ear tag number and select from the list |

    @LREG-783
    #Max length errors not on prototype so this will fail
    @fixme
    Scenario: Genetic Dam Details - Max length errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I enter 255 characters into the "Animal ear tag number" field
        And I continue from the "Genetic dam details" page
        Then the "Animal ear tag number" field shows the error "Maximum 64 characters"

    @LREG-783
    Scenario Outline: Genetic Dam Details - <field> - <case> - no results found
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                 | case                          | value          |
            | Animal ear tag number | invalid format                | £$%^&&         |
            | Animal ear tag number | valid format but doesnt exist | UK000000000000 |

    @LREG-783
    Scenario Outline: Genetic Dam Details - <field> - search using <case> '<searchTerm>' - matching dams are suggested
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        And the "<field>" field shows no more than 10 suggestions
        Examples: Partial and full ear tags
            | field                 | case          | searchTerm     | suggestion     |
            | Animal ear tag number | last 3 digits | 101            | UK123456501101 |
            | Animal ear tag number | herd mark     | 123456         | UK123456501101 |
            | Animal ear tag number | full ear tag  | UK123456501101 | UK123456501101 |

    @LREG-783
    Scenario: Genetic Dam Details - Select a dam from the suggestions and continue
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I search for "101" in the "Animal ear tag number" field
        And I select "UK123456501101" from the "Animal ear tag number" field suggestions
        And I continue from the "Genetic dam details" page
        Then I should see the heading "Sire details"

    @LREG-784
    #The errors match the story which is not the same as the prototype so this will fail until the correct errors are in mvp
    @fixme
    Scenario: Surrogate Dam Details - Empty field errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam details"
        When I continue from the "Genetic and surrogate dam details" page
        Then I should see the errors:
            | Enter the full animal ear tag number of the genetic dam   |
            | Enter the full animal ear tag number of the surrogate dam |

    @LREG-784
    #Max length errors not on prototype so this will fail
    @fixme
    Scenario: Surrogate Dam Details - Max length errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam details"
        When I enter 255 characters into the "Genetic dam ear tag number" field
        When I enter 255 characters into the "Surrogate dam ear tag number" field
        And I continue from the "Genetic and surrogate dam" page
        Then the "Genetic dam ear tag number" field shows the error "Maximum 64 characters"
        Then the "Surrogate dam ear tag number" field shows the error "Maximum 64 characters"

    @LREG-784
    Scenario Outline: Surrogate Dam Details - <field> - <case> - no results found
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam"
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                        | case                          | value          |
            | Surrogate dam ear tag number | invalid format                | £$%^&&         |
            | Surrogate dam ear tag number | valid format but doesnt exist | UK000000000000 |

        #Genetic dam ear tag number does not have lookup on prototype so this will fail until the lookup is added
        @fixme
        Examples:
            | field                      | case                          | value          |
            | Genetic dam ear tag number | invalid format                | £$%^&&         |
            | Genetic dam ear tag number | valid format but doesnt exist | UK000000000000 |


    @LREG-784
    Scenario Outline: Surrogate Dam Details - <field> - search using <case> '<searchTerm>' - matching dams are suggested
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam"
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        And the "<field>" field shows no more than 10 suggestions
        Examples: Partial and full ear tags
            | field                        | case          | searchTerm     | suggestion     |
            | Surrogate dam ear tag number | last 3 digits | 200            | UK123456601200 |
            | Surrogate dam ear tag number | herd mark     | 123456         | UK123456601200 |
            | Surrogate dam ear tag number | full ear tag  | UK123456601200 | UK123456601200 |

        #Genetic dam ear tag number does not have lookup on prototype so this will fail until the lookup is added
        @fixme
        Examples:
            | Genetic dam ear tag number | last 3 digits | 102            | UK123456501102 |
            | Genetic dam ear tag number | herd mark     | 123456         | UK123456501102 |
            | Genetic dam ear tag number | full ear tag  | UK123456501102 | UK123456501102 |

    @LREG-784
    # This validation is not on the prototype so this will fail until it is added
    @fixme
    Scenario: Surrogate Dam Details - Entering the same ear tag for both genetic and surrogate dam
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456501101"
        Then I should see the error "The genetic dam and surrogate dam ear tag numbers cannot be the same"

    #Max length errors not on prototype so this will fail
    @fixme
    Scenario: Sire Details - Max length errors
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        When I enter 255 characters into the "Sire ear tag number (optional)" field
        When I enter 255 characters into the "Sire name (optional)" field
        And I continue from the "Sire details" page
        Then the "Sire ear tag number (optional)" field shows the error "Maximum 64 characters"
        Then the "Sire name (optional)" field shows the error "Maximum 64 characters"

    Scenario Outline: Sire Details - <field> - <case> - no results found
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                          | case                          | value          |
            | Sire ear tag number (optional) | invalid format                | £$%^&&         |
            | Sire ear tag number (optional) | valid format but doesnt exist | UK000000000000 |
            | Sire name (optional)           | invalid format                | £$%^&&         |

    #Sire ear tag number does not have lookup on prototype so this will fail until the lookup is added
    @fixme
    Scenario Outline: Sire Details - <field> - search using <case> '<searchTerm>' - matching tags are suggested
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        And the "<field>" field shows no more than 10 suggestions
        Examples: Partial and full ear tags
            | field                          | case          | searchTerm     | suggestion     |
            | Sire ear tag number (optional) | last 3 digits | 103            | UK123456501103 |
            | Sire ear tag number (optional) | herd mark     | 123456         | UK123456501103 |
            | Sire ear tag number (optional) | full ear tag  | UK123456501103 | UK123456501103 |

    @LREG-781 @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register new cattle birth - Empty field error
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        And I continue from the "Register new cattle births" page
        Then I should see the error "Select yes to add additional animals or no to continue"


    # Ear tag formats from the BA. The validation is in the next release, so remove @fixme then.
    # The ear tags are the BA's examples: replace them with the test data given with the release.
    # - EU imports keep their original ear tag (non-EU imports are given new UK ear tags)
    # - Pre-June 2000 UK ear tags were alphanumeric, e.g. UK AB1234 00123. They aren't issued any
    #   more, but legacy ear tags are still in the systems and must be accepted
    # Lookup fields need animals with these ear tags in the test data to select
    @fixme
    Scenario Outline: Calf Details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        When I submit valid calf details with "<earTag>", "today", "Female", and "Baltata Romaneasca (BRO)"
        Then I am on the "Dam details" page

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |

    @fixme
    Scenario Outline: Genetic Dam Details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        When I add the ear tag of the dam as "<earTag>"
        Then I am on the "Sire details" page

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |

    @fixme
    Scenario Outline: Surrogate Dam Details - <type> ear tags '<geneticDam>' and '<surrogateDam>' are accepted
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via surrogate dam"
        When I add a genetic dam ear tag number as "<geneticDam>" and a surrogate dam ear tag number as "<surrogateDam>"
        Then I am on the "Sire details" page

        Examples:
            | type        | geneticDam      | surrogateDam    |
            | EU import   | IE123456789012  | FR123456789012  |
            | EU import   | DE123456789012  | IE123456789013  |
            | Pre-2000 UK | UK AB1234 00123 | IE123456789012  |

    @fixme
    Scenario Outline: Sire Details - Sire ear tag number - <type> ear tag '<earTag>' is accepted
        And I submit valid calf details with "UK123456301550", "11/2/2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        When I add sire details with "<earTag>" and "Sire Name"
        Then I am on the "Check calf details" page

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |
