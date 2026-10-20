@ui @frontoffice @dev @herokuapp
Feature: Cattle -  Register Cattle Birth - Positive scenarios

    Background:
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    Scenario: Register a cattle birth via genetic dam with with sire details
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK123456301550           |
            | Date of birth              | 11 February 2025         |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK123456501101           |
            | Sire ear tag number        | UK123456501103           |
            | Sire name                  | Sire Name                |
        And I verify tag number "UK123456301550" is "Ready to send"
        And I click on the tag number "UK123456301550"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK123456301550           |
            | Date of birth              | 11 February 2025         |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK123456501101           |
            | Sire ear tag number        | UK123456501103           |
            | Sire name                  | Sire Name                |
        And I submit "No" for add more animals
        And I send my cattle birth report
        Then I verify that "5 cattle births registered"


    Scenario: Register a cattle birth via genetic dam then change details from the summary page
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "30", "4", "2025", "Male", and "Danish Red (DR)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value  |
            | Animal ear tag number      | UK123456301550  |
            | Date of birth              | 30 April 2025   |
            | Sex                        | Male            |
            | Breed                      | Danish Red (DR) |
            | Dam type                   | Genetic         |
            | Genetic dam ear tag number | UK123456501101  |
            | Sire ear tag number        | Not provided    |
            | Sire name                  | Not provided    |
        And I change the "Sex" of the calf

    Scenario: Register a cattle birth via genetic dam with with sire details and add another animal
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK123456301550           |
            | Date of birth              | 11 February 2025         |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK123456501101           |
            | Sire ear tag number        | UK123456501103           |
            | Sire name                  | Sire Name                |
        And I verify tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals
        And I submit valid calf details with "UK123456301554", "21", "3", "2024", "Female", and "Charolais (CH)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501103"
        And I add sire details with "UK123456501103" and "Sire Name2"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301554 |
            | Date of birth              | 21 March 2024  |
            | Sex                        | Female         |
            | Breed                      | Charolais (CH) |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501103 |
            | Sire ear tag number        | UK123456501103 |
            | Sire name                  | Sire Name2     |
        And I verify tag number "UK123456301554" is "Ready to send"
        And I submit "No" for add more animals
        And I send my cattle birth report
        Then I verify that "5 cattle births registered"

    Scenario: Register a cattle birth and cancel a draft registration
        And I select Cancel on Draft registrations
        And I confirm the cancellation
    # Cancel draft button not functional
    # Then I am returned to Register new cattle births page

    Scenario: Register a cattle birth, cancel a draft then abort cancellation
        And I select Cancel on Draft registrations
        And I select Go back on the cancellation confirmation page
        Then I am returned to Register cattle births page

    Scenario: Register a cattle birth, continue a draft registration
        And I select Continue on Draft registrations
        Then I verify tag number "UK 312545 670001" is in "Ready to send" status
        Then I verify tag number "UK 312545 670002" is in "Incomplete" status

    Scenario: Register a cattle birth open historical registration thats in Pending validation status
        And I verify reference number "7KWM-3HTP" is "Pending validation"
        And I click on reference number "7KWM-3HTP" from the history registrations
        Then I verify the submission details page has:
            | Field            | Expected value            |
            | Reference number | 7KWM-3HTP                 |
            | Submission date  | 22 Sep 2026               |
            | Total animals    | 4                         |
            | Type             | Cattle birth registration |
            | Status           | Pending validation        |
        Then I verify the Animals registered table has:
            | Ear tag number   | Date of birth | Date on holding | Sex    | Breed |
            | UK 123456 301550 | 2 Sep 2026    | 2 Sep 2026      | Male   | HER   |
            | UK 123456 301551 | 2 Sep 2026    | 2 Sep 2026      | Female | HER   |
            | UK 123456 301552 | 5 Sep 2026    | 5 Sep 2026      | Male   | HER   |
            | UK 123456 301553 | 5 Sep 2026    | 5 Sep 2026      | Female | HER   |

    Scenario: Register a cattle birth open historical registration thats in Approved status
        And I verify reference number "M6QA-2JVE" is "Approved"
        And I click on reference number "M6QA-2JVE" from the history registrations
        Then I verify the submission details page has:
            | Field              | Expected value            |
            | Reference number   | M6QA-2JVE                 |
            | Submission date    | 14 Aug 2026               |
            | Total animals      | 3                         |
            | Type               | Cattle birth registration |
            | Status             | Approved                  |
            | Outstanding errors | 1                         |
        Then I verify the Animals registered table has:
            | Ear tag number   | Date of birth | Date on holding | Sex    | Breed | Errors |
            | UK 123456 301543 | 25 Jul 2026   | 25 Jul 2026     | Male   | LIM   | 0      |
            | UK 123456 301544 | 28 Jul 2026   | 28 Jul 2026     | Female | LIM   | 1      |
            | UK 123456 301545 | 30 Jul 2026   | 30 Jul 2026     | Female | LIM   | 0      |

    Scenario: Register a cattle birth via genetic dam with with sire details and then cancel
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Continue" on the cancellation confirmation page
        Then I am returned to Register new cattle births page

    Scenario: Register a cattle birth via genetic dam with with sire details, cancel and then abort the cancellation
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Cancel" on the cancellation confirmation page
        Then I am returned to Check calf details summary page

    Scenario: Register a cattle birth via genetic dam with no sire details
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "1", "1", "2025", "Male", and "Aberdeen Angus (AA)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add no sire details
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value      |
            | Animal ear tag number      | UK123456301550      |
            | Date of birth              | 1 January 2025      |
            | Sex                        | Male                |
            | Breed                      | Aberdeen Angus (AA) |
            | Dam type                   | Genetic             |
            | Genetic dam ear tag number | UK123456501101      |
            | Sire ear tag number        | Not provided        |
            | Sire name                  | Not provided        |
        And I verify tag number "UK123456301550" is "Ready to send"
        And I submit "No" for add more animals
        And I send my cattle birth report
        Then I verify that "5 cattle births registered"

    Scenario: Register a cattle birth via surrogate dam with no sire details
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "1", "1", "2025", "Male", and "Aberdeen Angus (AA)"
        And I submit the dam details as "calf born via surrogate dam"
    # no surrogate test data
    # And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456501102"
    # And I add no sire details
    # Then I verify the Check calf details summary page has:
    #     | Field                      | Expected value      |
    #     | Animal ear tag number      | UK123456301550      |
    #     | Date of birth              | 1 January 2025      |
    #     | Sex                        | Male                |
    #     | Breed                      | Aberdeen Angus (AA) |
    #     | Dam type                   | Surrogate           |
    #     | Genetic dam ear tag number | UK123456501101      |
    #     | Sire ear tag number        | Not provided        |
    #     | Sire name                  | Not provided        |
    # And I verify tag number "UK123456301550" is "Ready to send"
    # And I submit "No" for add more animals
    # And I send my cattle birth report
    # Then I verify that "5 cattle births registered"

    Scenario: Register a cattle birth via surrogate dam with sire details
        And I start birth registration process
        And I submit valid calf details with "UK123456301550", "1", "1", "2025", "Male", and "Aberdeen Angus (AA)"
        And I submit the dam details as "calf born via surrogate dam"
# no surrogate test data
# And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456501102"
# And I add sire details with "UK123456501103" and "Sire Name"
# Then I verify the Check calf details summary page has:
#     | Field                      | Expected value      |
#     | Animal ear tag number      | UK123456301550      |
#     | Date of birth              | 1 January 2025      |
#     | Sex                        | Male                |
#     | Breed                      | Aberdeen Angus (AA) |
#     | Dam type                   | Surrogate           |
#     | Genetic dam ear tag number | UK123456501101      |
#     | Sire ear tag number        | Not provided        |
#     | Sire name                  | Not provided        |
# And I verify tag number "UK123456301550" is "Ready to send"
# And I submit "No" for add more animals
# And I send my cattle birth report
# Then I verify that "5 cattle births registered"