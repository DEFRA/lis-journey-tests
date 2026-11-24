@ui @frontoffice @dev @cattlebirth @cattlebirthpositive
Feature: Cattle - Register a Cattle Birth - Positive scenarios

    Background: Sign in to the MVP and start Register a cattle birth
        Given I am authenticated as a front office user with a single CPH holding
        And I select Register a cattle birth

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam with sire details
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I click on the "UK 324537 100001" ear tag link
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Animal ear tag number of the calf from the summary page
        And I submit valid calf details with "UK324537100002", "27 days ago", "Male", and "Danish Red (DR)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100002 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Animal ear tag number" of the calf
        And I submit valid calf details with "UK324537100001", "27 days ago", "Male", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100001 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Date of birth of the calf from the summary page
        And I submit valid calf details with "UK324537100003", "27 days ago", "Male", and "Danish Red (DR)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100003 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Date of birth" of the calf
        And I submit valid calf details with "UK324537100001", "20 days ago", "Male", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100001 |
            | Date of birth              | 20 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Sex of the calf from the summary page
        And I submit valid calf details with "UK324537100004", "27 days ago", "Male", and "Danish Red (DR)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100004 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Sex" of the calf
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100001 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Breed of the calf from the summary page
        And I submit valid calf details with "UK324537100005", "27 days ago", "Male", and "Danish Red (DR)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100005 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Danish Red (DR)  |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Breed" of the calf
        And I submit valid calf details with "UK324537100001", "27 days ago", "Male", and "Yak (YK)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100001 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Yak (YK)         |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Dam type from the summary page
        And I submit valid calf details with "UK324537100006", "27 days ago", "Male", and "Estonian Red (ER)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK 324537 100006  |
            | Date of birth              | 27 days ago       |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK 200000 000007  |
            | Sire ear tag number        | UK 200000 000008  |
            | Sire name                  | Sire Name         |
        And I change the "Dam type" of the calf
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100006  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Male              |
            | Breed                        | Estonian Red (ER) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000007  |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Genetic dam ear tag number from the summary page
        And I submit valid calf details with "UK324537100007", "27 days ago", "Male", and "Estonian Red (ER)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK 324537 100007  |
            | Date of birth              | 27 days ago       |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK 200000 000007  |
            | Sire ear tag number        | UK 200000 000008  |
            | Sire name                  | Sire Name         |
        And I change the "Genetic dam ear tag number" of the calf
        And I add the ear tag of the dam as "UK200000000007"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK 324537 100007  |
            | Date of birth              | 27 days ago       |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK 200000 000007  |
            | Sire ear tag number        | UK 200000 000008  |
            | Sire name                  | Sire Name         |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Sire Ear tag from the summary page
        And I submit valid calf details with "UK324537100008", "27 days ago", "Female", and "Flekvieh (FKV)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100008 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Flekvieh (FKV)   |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Sire ear tag number" of the calf
        And I submit the sire ear tag number as "UK123456501105"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100008 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Flekvieh (FKV)   |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 123456 501105 |
            | Sire name                  | Sire Name        |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam then change the Sire Name from the summary page
        And I submit valid calf details with "UK324537100009", "27 days ago", "Female", and "Flekvieh (FKV)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100009 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Flekvieh (FKV)   |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name        |
        And I change the "Sire name" of the calf
        And I submit the sire name as "Sire Name 2"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100009 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Flekvieh (FKV)   |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name 2      |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam with sire details and add another animal
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I submit "Yes" for add more animals for births
        And I submit valid calf details with "UK324537100002", "27 days ago", "Female", and "Charolais (CH)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name2"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100002 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Female           |
            | Breed                      | Charolais (CH)   |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | UK 200000 000008 |
            | Sire name                  | Sire Name2       |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100002" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "2 cattle births registered"

    # Cancel draft button not functional
    @fixme
    Scenario: Register a cattle birth - Cancel a draft registration and return to Register new cattle births
        And I select Cancel on Draft registrations
        And I confirm the cancellation
        Then I am returned to Register new cattle births page

    # Cancel draft button not functional
    @fixme
    Scenario: Register a cattle birth - Go back from cancelling a draft registration
        And I select Cancel on Draft registrations
        And I select Go back on the cancellation confirmation page
        Then I am returned to Register cattle births page

    @fixme
    Scenario: Register a cattle birth - Continuing a draft registration shows the status of each calf
        And I select Continue on Draft registrations
        Then I verify birth tag number "UK 312545 670001" is in "Ready to send" status
        Then I verify birth tag number "UK 312545 670002" is in "Incomplete" status

    @fixme
    Scenario: Register a cattle birth - Opening a Pending validation registration from history shows its submission details and animals
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
            | UK 324537 100002 | 2 Sep 2026    | 2 Sep 2026      | Female | HER   |
            | UK 123456 301552 | 5 Sep 2026    | 5 Sep 2026      | Male   | HER   |
            | UK 123456 301553 | 5 Sep 2026    | 5 Sep 2026      | Female | HER   |

    @fixme
    Scenario: Register a cattle birth - Opening an Approved registration from history shows its submission details and animal errors
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

    # Uses the same history navigation as the scenario above, so it is @fixme until that works
    @fixme
    Scenario Outline: Register a cattle birth - The Animals registered table on an Approved registration sorts by <column>
        And I verify reference number "M6QA-2JVE" is "Approved"
        And I click on reference number "M6QA-2JVE" from the history registrations
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<firstClick>" order
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<secondClick>" order

        # Ear tag number is assumed to load sorted ascending, like the other sortable tables, so the first click flips it
        Examples:
            | column          | firstClick | secondClick |
            | Ear tag number  | descending | ascending   |
            | Date of birth   | ascending  | descending  |
            | Date on holding | ascending  | descending  |
            | Sex             | ascending  | descending  |
            | Breed           | ascending  | descending  |
            | Errors          | ascending  | descending  |

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam with sire details and then cancel the registration
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Yes" on the cancellation confirmation page
        Then I am returned to Register new cattle births page
        And I should see the message "You have not added any animals to this registration."

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam with sire details, cancel and then abort the cancellation
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "No" on the cancellation confirmation page
        Then I am returned to Check calf details summary page

    # The cancel draft scenarios below need the draft functionality, which is not on the MVP yet: remove @fixme then
    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    @fixme
    Scenario: Register a cattle birth via genetic dam with sire details, cancel - the draft is discarded
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Yes" on the cancellation confirmation page
        Then I am returned to Register new cattle births page
        And birth tag number "UK 324537 100001" is not listed

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    @fixme
    Scenario: Register a cattle birth via genetic dam with sire details, abort the cancellation - the draft is kept
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "No" on the cancellation confirmation page
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    @fixme
    Scenario: Register a cattle birth via genetic dam with sire details, cancel and then go Back - the draft is kept
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I cancel the cattle birth registration
        And I select Back on the cancellation confirmation page
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        # Clears the test data
        And I cancel the cattle birth registration
        And I select "Yes" on the cancellation confirmation page
        Then I am returned to Register new cattle births page

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth via genetic dam with no sire details
        And I submit valid calf details with "UK324537100001", "27 days ago", "Male", and "Guernsey (GU)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add no sire details
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value   |
            | Animal ear tag number      | UK 324537 100001 |
            | Date of birth              | 27 days ago      |
            | Sex                        | Male             |
            | Breed                      | Guernsey (GU)    |
            | Dam type                   | Genetic          |
            | Genetic dam ear tag number | UK 200000 000007 |
            | Sire ear tag number        | Not provided     |
            | Sire name                  | Not provided     |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via surrogate dam with no sire details
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Heck (HK)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add no sire details
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value   |
            | Animal ear tag number        | UK 324537 100001 |
            | Date of birth                | 27 days ago      |
            | Sex                          | Female           |
            | Breed                        | Heck (HK)        |
            | Dam type                     | Surrogate        |
            | Genetic dam ear tag number   | UK 200000 000007 |
            | Surrogate dam ear tag number | UK 300000 000023 |
            | Sire ear tag number          | Not provided     |
            | Sire name                    | Not provided     |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via surrogate dam with sire details
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000007  |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via surrogate dam then change the surrogate dam ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000007  |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |
        And I change the "Surrogate dam ear tag number" of the calf
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000021"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000007  |
            | Surrogate dam ear tag number | UK 300000 000021  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |
        And I continue from the "Check calf details" page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via surrogate dam then change the genetic dam ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I change the "Genetic dam ear tag number" of the calf
        And I add a genetic dam ear tag number as "UK200000000009" and a surrogate dam ear tag number as "UK300000000023"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000009  |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |

    @LREG-781 @LREG-782 @LREG-783 @LREG-784 @LREG-785
    Scenario: Register a cattle birth via surrogate dam then change the Dam type to genetic from the summary page
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        And I change the "Dam type" of the calf
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000009"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK 324537 100001  |
            | Date of birth              | 27 days ago       |
            | Sex                        | Female            |
            | Breed                      | Irish Moiled (IM) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK 200000 000009  |
            | Sire ear tag number        | UK 200000 000008  |
            | Sire name                  | Sire Name         |
        And the Check calf details summary page does not show "Surrogate dam ear tag number"

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    # The genetic dam ear tag is optional on the surrogate dam page, and shows "Not provided" when left empty
    Scenario: Register a cattle birth via surrogate dam with no genetic dam ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | Not provided      |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Go back from Register cattle birth via genetic dam page and verify entered details remain
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | 27 days ago              |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        When I select Back from the Check calf details page
        And the previously entered sire details are still populated:
            | Sire ear tag number | UK200000000008 |
            | Sire name           | Sire Name      |
        When I select Back from the Sire details page
        And the previously entered Genetic Dam details are still populated:
            | Genetic dam ear tag number | UK200000000007 |
        When I select Back from the Dam details page
        And the previously entered Dam type "Calf born via genetic dam" is still checked:
        When I select Back from the Dam type page
        And the previously entered calf details are still populated:
            | Animal ear tag number | UK324537100001           |
            | Date of birth         | 27 days ago              |
            | Sex                   | Female                   |
            | Breed                 | Baltata Romaneasca (BRO) |

    @LREG-781 @LREG-782 @LREG-784 @LREG-785
    Scenario: Go back from Register a cattle birth via surrogate dam and verify entered details remain
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "Calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK200000000007" and a surrogate dam ear tag number as "UK300000000023"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK 324537 100001  |
            | Date of birth                | 27 days ago       |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK 200000 000007  |
            | Surrogate dam ear tag number | UK 300000 000023  |
            | Sire ear tag number          | UK 200000 000008  |
            | Sire name                    | Sire Name         |
        When I select Back from the Check calf details page
        And the previously entered sire details are still populated:
            | Sire ear tag number | UK200000000008 |
            | Sire name           | Sire Name      |
        When I select Back from the Sire details page
        And the previously entered Surrogate Dam details are still populated:
            | Genetic dam ear tag number   | UK200000000007 |
            | Surrogate dam ear tag number | UK300000000023 |
        When I select Back from the Dam details page
        And the previously entered Dam type "Calf born via surrogate dam" is still checked:
        When I select Back from the Dam type page
        And the previously entered calf details are still populated:
            | Animal ear tag number | UK324537100001    |
            | Date of birth         | 27 days ago       |
            | Sex                   | Female            |
            | Breed                 | Irish Moiled (IM) |

    @LREG-781 @LREG-785
    @fixme
    # Nothing has been submitted, so there is no registration to go back to
    Scenario: Go back from Calf details before submitting it - returned to the holding overview
        When I select Back from the Calf details page
        Then I am returned to the holding overview page

    @LREG-781 @LREG-782 @LREG-785
    @fixme
    # Submitting calf details adds the calf to the registration, so going back shows it as Incomplete
    Scenario: Go back from Calf details after submitting it - the calf is shown as Incomplete
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        When I select Back from the Dam type page
        And I select Back from the Calf details page
        Then I am returned to Register new cattle births page
        And I verify birth tag number "UK 324537 100001" is "Incomplete"

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    Scenario: Register a cattle birth with todays date as date of birth
        And I submit valid calf details with "UK324537100001", "today", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add sire details with "UK200000000008" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK 324537 100001         |
            | Date of birth              | today                    |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK 200000 000007         |
            | Sire ear tag number        | UK 200000 000008         |
            | Sire name                  | Sire Name                |
        And I continue from the "Check calf details" page
        And I verify birth tag number "UK 324537 100001" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
    # Sending the report is not on the MVP until next sprint: uncomment these two steps then
    # Then I verify that "1 cattle birth registered"

    @LREG-782
    Scenario: Register a cattle birth - Dam details caption shows the calf ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        Then the "Dam details" page caption shows "Official animal ear tag number: UK 324537 100001"

    @LREG-783
    Scenario: Register a cattle birth - Genetic dam details caption shows the calf ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        Then the "Genetic dam details" page caption shows "Official animal ear tag number: UK 324537 100001"

    @LREG-784
    Scenario: Register a cattle birth - Genetic and surrogate dam details caption shows the calf ear tag number
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        Then the "Genetic and surrogate dam details" page caption shows "Official animal ear tag number: UK 324537 100001"

    @LREG-781
    Scenario Outline: Calf Details - <field> - search using <case> '<searchTerm>' - matching tags are suggested
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        Examples: Partial and full ear tags
            | field                 | case          | searchTerm     | suggestion     |
            | Animal ear tag number | last 3 digits | 001            | UK324537100001 |
            | Animal ear tag number | herd mark     | 3245371        | UK324537100001 |
            | Animal ear tag number | full ear tag  | UK324537100001 | UK324537100001 |

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
    # The breed suggestions ignore case and match on the code alone.
    # They don't accept "x" for "cross": that is only matched on submit (see the typed breed scenario below)
    Scenario Outline: Calf Details - Breed - search using <case> '<searchTerm>' - the breed is suggested
        When I search for "<searchTerm>" in the "Breed" field
        Then the "Breed" field suggests "<suggestion>"
        Examples:
            | case                  | searchTerm   | suggestion         |
            | lower case name       | sussex cross | Sussex Cross (SUX) |
            | lower case breed code | sux          | Sussex Cross (SUX) |

    @LREG-781 @LREG-782 @LREG-783 @LREG-785
    # A calf already in the registration is removed from the lookup, so it can't be added twice
    Scenario: Register a cattle birth - Add another animal - a calf already added is not suggested
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        And I add no sire details
        And I continue from the "Check calf details" page
        And I submit "Yes" for add more animals for births
        When I search for "3245371" in the "Animal ear tag number" field
        Then the "Animal ear tag number" field does not suggest "UK324537100001"

    @LREG-781
    # A breed typed without picking a suggestion is matched when the form is submitted. This is the
    # fallback for when JavaScript hasn't loaded: it ignores case, matches the code alone, and accepts
    # "x" for "cross". The other fields are cleared so the page stays on Calf details, where the breed
    # can be checked. Assumes the matched breed is shown in the field: update this if it isn't
    Scenario Outline: Calf Details - Breed - typed '<typed>' but no suggestion picked - <breed> is selected
        When I clear the calf details
        And I search for "<typed>" in the "Breed" field
        And I continue from the "Calf details" page
        Then the "Breed" field has the value "<breed>"

        Examples:
            | typed        | breed              |
            | Danish Red   | Danish Red (DR)    |
            | sussex cross | Sussex Cross (SUX) |
            | sussex x     | Sussex Cross (SUX) |
            | sux          | Sussex Cross (SUX) |

    @LREG-783
    Scenario Outline: Genetic Dam Details - <field> - search using <case> '<searchTerm>' - matching dams are suggested
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        Examples: Partial and full ear tags
            | field                 | case          | searchTerm     | suggestion     |
            | Animal ear tag number | last 3 digits | 007            | UK200000000007 |
            | Animal ear tag number | herd mark     | 200000         | UK200000000007 |
            | Animal ear tag number | full ear tag  | UK200000000007 | UK200000000007 |

    @LREG-783
    Scenario: Genetic Dam Details - Animal ear tag number - typing more of the ear tag narrows the suggestions
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        Then searching "1" then "UK200000000007" in the "Animal ear tag number" field suggests fewer matches

    @LREG-783
    Scenario: Genetic Dam Details - Select a dam from the suggestions and continue
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I search for "001" in the "Animal ear tag number" field
        And I select "UK300000000011" from the "Animal ear tag number" field suggestions
        And I continue from the "Genetic dam details" page
        Then I should see the heading "Sire details"

    @LREG-784
    Scenario Outline: Surrogate Dam Details - <field> - search using <case> '<searchTerm>' - matching dams are suggested
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I search for "<searchTerm>" in the "<field>" field
        Then the "<field>" field suggests "<suggestion>"
        And every suggestion in the "<field>" field contains "<searchTerm>"
        Examples: Partial and full ear tags
            | field                        | case          | searchTerm     | suggestion     |
            | Surrogate dam ear tag number | last 3 digits | 023            | UK300000000023 |
            | Surrogate dam ear tag number | herd mark     | 300000         | UK300000000023 |
            | Surrogate dam ear tag number | full ear tag  | UK300000000023 | UK300000000023 |

    @LREG-784
    Scenario: Surrogate Dam Details - Select a surrogate dam from the suggestions and continue
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I search for "UK200000000007" in the "Genetic dam ear tag number (optional)" field
        And I search for "200" in the "Surrogate dam ear tag number" field
        And I select "UK200000000009" from the "Surrogate dam ear tag number" field suggestions
        And I continue from the "Genetic and surrogate dam details" page
        Then I should see the heading "Sire details"

    @LREG-784
    # The genetic dam ear tag is not validated, only the surrogate dam ear tag is
    Scenario: Surrogate Dam Details - A genetic dam ear tag that is not in the herd is accepted
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I add a genetic dam ear tag number as "UK000000000000" and a surrogate dam ear tag number as "UK300000000023"
        Then I should see the heading "Sire details"

    # The sire ear tag and name are optional free text with no validation yet. The BA says
    # validation will probably be added later: check these cases are still accepted when it is
    @fixme
    Scenario Outline: Sire Details - <case> - is accepted
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        And I add the ear tag of the dam as "UK200000000007"
        When I add sire details with "<earTag>" and "<name>"
        Then I should see the heading "Check calf details"

        Examples:
            | case                         | earTag          | name      |
            | ear tag not in the herd      | UK000000000000  | Sire Name |
            | name with special characters | UK200000000007  | £$%^&&    |
            | EU import ear tag            | IE123456789012  | Sire Name |
            | Pre-2000 UK ear tag          | UK AB1234 00123 | Sire Name |

    # Ear tag formats from the BA. The validation is in the next release, so remove @fixme then.
    # The ear tags are the BA's examples: replace them with the test data given with the release.
    # - EU imports keep their original ear tag (non-EU imports are given new UK ear tags)
    # - Pre-June 2000 UK ear tags were alphanumeric, e.g. UK AB1234 00123. They aren't issued any
    #   more, but legacy ear tags are still in the systems and must be accepted
    # Lookup fields need animals with these ear tags in the test data to select
    @fixme
    Scenario Outline: Calf Details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        When I submit valid calf details with "<earTag>", "today", "Female", and "Baltata Romaneasca (BRO)"
        Then I should see the heading "Dam details"

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |

    @fixme
    Scenario Outline: Genetic Dam Details - Animal ear tag number - <type> ear tag '<earTag>' is accepted
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via genetic dam"
        When I add the ear tag of the dam as "<earTag>"
        Then I should see the heading "Sire details"

        Examples:
            | type        | earTag          |
            | EU import   | IE123456789012  |
            | EU import   | FR123456789012  |
            | EU import   | DE123456789012  |
            | Pre-2000 UK | UK AB1234 00123 |

    @fixme
    Scenario Outline: Surrogate Dam Details - <type> ear tags '<geneticDam>' and '<surrogateDam>' are accepted
        And I submit valid calf details with "UK324537100001", "27 days ago", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "Calf born via surrogate dam"
        When I add a genetic dam ear tag number as "<geneticDam>" and a surrogate dam ear tag number as "<surrogateDam>"
        Then I should see the heading "Sire details"

        Examples:
            | type        | geneticDam      | surrogateDam   |
            | EU import   | IE123456789012  | FR123456789012 |
            | EU import   | DE123456789012  | IE123456789013 |
            | Pre-2000 UK | UK AB1234 00123 | IE123456789012 |
