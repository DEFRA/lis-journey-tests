@ui @frontoffice @dev  @cattlebirth @cattlebirthnegative
Feature: Cattle - Register a Cattle Birth - Validation

    Background: Sign in to the MVP and start Register a cattle birth
        Given I am authenticated as a front office user with a single CPH holding
        And I select Register a cattle birth

    @LREG-781
    Scenario: Calf Details - Empty field errors
        When I clear the calf details
        # Temporary: remove when tests can create their own test users/sessions
        And I clear the sex of the calf
        And I continue from the "Calf details" page
        Then I should see the errors:
            | Enter the last 6 digits of the animal ear tag number you are registering |
            | Enter the date the animal was born                                       |
            | Select if the animal is male or female                                   |
            | Enter the animal breed or breed code                                     |

    @LREG-781
    Scenario Outline: Calf Details - Date Of Birth errors - <case>
        When I enter calf details with "<earTag>", "<dob>", "<sex>", and "<breed>"
        Then I should see the error "<error>"

        Examples:
            | case                      | earTag         | dob         | sex    | breed           | error                                                     |
            | date of birth in future   | UK324537100001 | 1/1/2099    | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | date of birth is tomorrow | UK324537100001 | tomorrow    | Female | Danish Red (DR) | Date of birth must be today or in the past                |
            | invalid date of birth     | UK324537100001 | ABCDEFG     | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | US style date of birth    | UK324537100001 | 12/20/2025  | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | Non leap year             | UK324537100001 | 29/02/2023  | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |
            | year has too many digits  | UK324537100001 | 01/05/20260 | Female | Danish Red (DR) | Date of birth must be a real date, for example 01/05/2026 |

    @LREG-781
    Scenario Outline: Calf Details - Max length errors - <field>
        When I enter 255 characters into the "<field>" field
        And I continue from the "Calf details" page
        Then the "<field>" field shows the error "<error>"

        Examples:
            | field                 | error                                                |
            | Animal ear tag number | Animal ear tag number must be 15 characters or fewer |
            | Breed                 | Breed must be 50 characters or fewer                 |

    @LREG-785 @fixme
    # Draft functionality is not in the MVP, so this fails until it is added.
    # No calf details have been entered, so there is no draft to cancel.
    # The URL in the step is made up, so this fails until it is replaced with the real one
    Scenario: Cancel this registration - Opening the page directly with no draft - redirected to Cattle on holding
        When I open the cancel registration page directly
        Then I should see the heading "Cattle on holding"

    @LREG-781
    # A date over the character limit isn't in the date format, so it gets the real date error
    Scenario: Calf Details - Date of birth over the character limit - error
        When I enter 255 characters into the "Date of birth" field
        And I continue from the "Calf details" page
        Then the "Date of birth" field shows the error "Date of birth must be a real date, for example 01/05/2026"

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
    Scenario: Calf Details - Date of birth more than 27 days in the past - late registration error
        When I enter calf details with "UK324537100001", "28 days ago", "Female", and "Danish Red (DR)"
        Then I should see the error "Date of birth is over the 27-day deadline to report a calf birth. Check the date, or select Continue to register the birth anyway."

    @LREG-782
    Scenario: Dam Details - Empty field errors
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        # Temporary: remove when tests can create their own test users/sessions
        And I clear the dam details
        When I continue from the "Dam details" page
        Then I should see the errors:
            | Select if the calf was born via a genetic or surrogate dam |
        And the error summary has focus

    @LREG-783
    Scenario: Genetic Dam Details - Empty field errors
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I clear the genetic dam details
        When I continue from the "Genetic dam details" page
        Then I should see the errors:
            | Enter the ear tag number of the genetic dam |

    @LREG-783
    Scenario: Genetic Dam Details - Max length errors
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I enter 255 characters into the "Animal ear tag number" field
        And I continue from the "Genetic dam details" page
        Then the "Animal ear tag number" field shows the error "Genetic dam ear tag number must be 15 characters or fewer"

    @LREG-783
    Scenario Outline: Genetic Dam Details - Animal ear tag number - <case> - no results found
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I search for "<value>" in the "Animal ear tag number" field
        Then the "Animal ear tag number" field shows No results found

        Examples:
            | case                          | value          |
            | invalid format                | £$%^&&         |
            | valid format but doesnt exist | UK000000000000 |

    @LREG-784
    Scenario: Surrogate Dam Details - Empty field errors
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I clear the surrogate dam details
        When I continue from the "Genetic and surrogate dam details" page
        Then I should see the errors:
            | Enter the ear tag number of the surrogate dam |

    @LREG-784
    Scenario: Surrogate Dam Details - Max length errors
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I enter 255 characters into the "Genetic dam ear tag number (optional)" field
        When I enter 255 characters into the "Surrogate dam ear tag number" field
        And I continue from the "Genetic and surrogate dam details" page
        Then the "Genetic dam ear tag number (optional)" field shows the error "Genetic dam ear tag number must be 15 characters or fewer"
        Then the "Surrogate dam ear tag number" field shows the error "Surrogate dam ear tag number must be 15 characters or fewer"

    @LREG-784
    Scenario Outline: Surrogate Dam Details - <field> - <case> - no results found
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I search for "<value>" in the "<field>" field
        Then the "<field>" field shows No results found

        Examples:
            | field                        | case                          | value          |
            | Surrogate dam ear tag number | invalid format                | £$%^&&         |
            | Surrogate dam ear tag number | valid format but doesnt exist | UK000000000000 |

    # Ear tag lookups are mandatory: typing part of an ear tag without picking a suggestion
    # shows an "on this holding" error, which differs from the empty field one. Calf details asks
    # for an available ear tag and the dam pages ask for a dam. Breed is different: a typed breed is
    # matched on submit, and only gets an error if it matches no breed
    @LREG-781
    Scenario: Calf Details - Animal ear tag number - typed but no suggestion picked - error
        When I clear the calf details
        And I search for "001" in the "Animal ear tag number" field
        And I continue from the "Calf details" page
        Then the "Animal ear tag number" field shows the error "Enter an ear tag number that is available on this holding"

    @LREG-781
    # A typed breed is matched on submit. One that matches no breed gets this error
    Scenario: Calf Details - Breed - typed breed that doesn't match any breed - error
        When I clear the calf details
        And I search for "Test (TEST)" in the "Breed" field
        And I continue from the "Calf details" page
        Then the "Breed" field shows the error "Enter the animal breed or breed code into the text box and select the correct one from the suggested options"

    @LREG-783
    Scenario: Genetic Dam Details - Animal ear tag number - typed but no suggestion picked - error
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I search for "007" in the "Animal ear tag number" field
        And I continue from the "Genetic dam details" page
        Then the "Animal ear tag number" field shows the error "Enter the ear tag number of a dam on this holding"

    @LREG-783
    # The genetic dam lookup only lists dams on the holding. The calf being registered isn't one,
    # so typing in its ear tag, or any ear tag not on the holding, is rejected
    Scenario Outline: Genetic Dam Details - <case> can't be used as the dam
        And I submit valid calf details with "UK324537100002", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I search for "<earTag>" in the "Animal ear tag number" field
        Then the "Animal ear tag number" field shows No results found
        When I continue from the "Genetic dam details" page
        Then the "Animal ear tag number" field shows the error "Enter the ear tag number of a dam on this holding"

        Examples:
            | case                          | earTag         |
            | the calf's own ear tag        | UK324537100002 |
            | an ear tag not on the holding | UK000000000000 |

    @LREG-784
    Scenario: Surrogate Dam Details - Surrogate dam ear tag number - typed but no suggestion picked - error
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I search for "023" in the "Surrogate dam ear tag number" field
        And I continue from the "Genetic and surrogate dam details" page
        Then the "Surrogate dam ear tag number" field shows the error "Enter the ear tag number of a dam on this holding"

    @LREG-784
    # Uses a surrogate dam ear tag, as only cows on the holding can be picked from the surrogate dam lookup
    Scenario: Surrogate Dam Details - Entering the same ear tag for both genetic and surrogate dam
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK300000000023" and a surrogate dam ear tag number as "UK300000000023"
        Then I should see the error "The genetic dam and surrogate dam ear tag numbers cannot be the same"

    # Sire details have no validation yet. The BA says it will probably be added later,
    # so this is commented out until then. The error is made up: replace it with the real one
    # Scenario Outline: Sire Details - Sire ear tag number - <case> - error
    #     And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
    #     And I submit the dam details as "Calf born via genetic dam"
    #     And I add the ear tag of the dam as "UK200000000007"
    #     When I add sire details with "<earTag>" and "Sire Name"
    #     Then I should see the error "Enter the sire ear tag number in the correct format"
    #     And the previously entered sire details are still populated:
    #         | Sire ear tag number | <earTag>  |
    #         | Sire name           | Sire Name |
    #
    #     Examples:
    #         | case               | earTag           |
    #         | illegal characters | £$%^&&           |
    #         | invalid prefix     | XX123456123456   |
    #         | too short          | UK123            |
    #         | too long           | UK12345612345678 |

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register new cattle birth - Empty field error
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I continue from the "Check calf details" page
        And I continue from the "Register new cattle births" page
        Then I should see the error "Select yes to add additional animals or no to continue"
