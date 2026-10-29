Feature: Cattle -  Register a Cattle Birth - Positive scenarios

    Background:
        Given I log into the herokuapp mvp
        And I select Register a cattle birth

    Scenario: Register a cattle birth via genetic dam with with sire details
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
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301550" is "Ready to send"
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
        And I select Continue from the Check calf details page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "1 cattle birth registered"

    Scenario: Register a cattle birth via genetic dam then change the Animal ear tag number of the calf from the summary page
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
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |
        And I change the "Animal ear tag number" of the calf
        And I submit valid calf details with "UK123456301551", "30", "4", "2025", "Male", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value  |
            | Animal ear tag number      | UK123456301551  |
            | Date of birth              | 30 April 2025   |
            | Sex                        | Male            |
            | Breed                      | Danish Red (DR) |
            | Dam type                   | Genetic         |
            | Genetic dam ear tag number | UK123456501101  |
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |

    Scenario: Register a cattle birth via genetic dam then change the Date of birth of the calf from the summary page
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
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |
        And I change the "Date of birth" of the calf
        And I submit valid calf details with "UK123456301550", "20", "5", "2025", "Male", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value  |
            | Animal ear tag number      | UK123456301550  |
            | Date of birth              | 20 May 2025     |
            | Sex                        | Male            |
            | Breed                      | Danish Red (DR) |
            | Dam type                   | Genetic         |
            | Genetic dam ear tag number | UK123456501101  |
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |

    Scenario: Register a cattle birth via genetic dam then change the Sex of the calf from the summary page
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
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |
        And I change the "Sex" of the calf
        And I submit valid calf details with "UK123456301550", "30", "4", "2025", "Female", and "Danish Red (DR)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value  |
            | Animal ear tag number      | UK123456301550  |
            | Date of birth              | 30 April 2025   |
            | Sex                        | Female          |
            | Breed                      | Danish Red (DR) |
            | Dam type                   | Genetic         |
            | Genetic dam ear tag number | UK123456501101  |
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |

    Scenario: Register a cattle birth via genetic dam then change the Breed of the calf from the summary page
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
            | Sire ear tag number        | UK123456501103  |
            | Sire name                  | Sire Name       |
        And I change the "Breed" of the calf
        And I submit valid calf details with "UK123456301550", "30", "4", "2025", "Male", and "Yak (YK)"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 30 April 2025  |
            | Sex                        | Male           |
            | Breed                      | Yak (YK)       |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | UK123456501103 |
            | Sire name                  | Sire Name      |

    Scenario: Register a cattle birth via genetic dam then change the Dam type from the summary page
        And I submit valid calf details with "UK123456301550", "1", "5", "2025", "Male", and "Estonian Red (ER)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK123456301550    |
            | Date of birth              | 1 May 2025        |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK123456501101    |
            | Sire ear tag number        | UK123456501103    |
            | Sire name                  | Sire Name         |
        And I change the "Dam type" of the calf
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456601200"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK123456301550    |
            | Date of birth                | 1 May 2025        |
            | Sex                          | Male              |
            | Breed                        | Estonian Red (ER) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK123456501101    |
            | Surrogate dam ear tag number | UK123456601200    |
            | Sire ear tag number          | UK123456501103    |
            | Sire name                    | Sire Name         |

    Scenario: Register a cattle birth via genetic dam then change the Genetic dam ear tag number from the summary page
        And I submit valid calf details with "UK123456301550", "1", "5", "2025", "Male", and "Estonian Red (ER)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK123456301550    |
            | Date of birth              | 1 May 2025        |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK123456501101    |
            | Sire ear tag number        | UK123456501103    |
            | Sire name                  | Sire Name         |
        And I change the "Genetic dam ear tag number" of the calf
        And I add the ear tag of the dam as "UK123456501102"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value    |
            | Animal ear tag number      | UK123456301550    |
            | Date of birth              | 1 May 2025        |
            | Sex                        | Male              |
            | Breed                      | Estonian Red (ER) |
            | Dam type                   | Genetic           |
            | Genetic dam ear tag number | UK123456501102    |
            | Sire ear tag number        | UK123456501103    |
            | Sire name                  | Sire Name         |

    Scenario: Register a cattle birth via genetic dam then change the Sire Ear tag from the summary page
        And I submit valid calf details with "UK123456301550", "13", "6", "2025", "Female", and "Flekvieh (FKV)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 13 June 2025   |
            | Sex                        | Female         |
            | Breed                      | Flekvieh (FKV) |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | UK123456501103 |
            | Sire name                  | Sire Name      |
        And I change the "Sire ear tag number" of the calf
        And I submit the sire ear tag number as "UK123456501105"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 13 June 2025   |
            | Sex                        | Female         |
            | Breed                      | Flekvieh (FKV) |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | UK123456501105 |
            | Sire name                  | Sire Name      |

    Scenario: Register a cattle birth via genetic dam then change the Sire Name from the summary page
        And I submit valid calf details with "UK123456301550", "13", "6", "2025", "Female", and "Flekvieh (FKV)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 13 June 2025   |
            | Sex                        | Female         |
            | Breed                      | Flekvieh (FKV) |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | UK123456501103 |
            | Sire name                  | Sire Name      |
        And I change the "Sire name" of the calf
        And I submit the sire name as "Sire Name 2"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 13 June 2025   |
            | Sex                        | Female         |
            | Breed                      | Flekvieh (FKV) |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | UK123456501103 |
            | Sire name                  | Sire Name 2    |

    Scenario: Register a cattle birth via genetic dam with with sire details and add another animal
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
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals for births
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
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301554" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "2 cattle births registered"

    # Cancel draft button not functional
    # Scenario: Register a cattle birth and cancel a draft registration
    #   And I select Cancel on Draft registrations
    #   And I confirm the cancellation
    #   Then I am returned to Register new cattle births page

    # Cancel draft button not functional
    # Scenario: Register a cattle birth, cancel a draft then abort cancellation
    #     And I select Cancel on Draft registrations
    #     And I select Go back on the cancellation confirmation page
    #     Then I am returned to Register cattle births page

    # Scenario: Register a cattle birth, continue a draft registration
    #     And I select Continue on Draft registrations
    #     Then I verify birth tag number "UK 312545 670001" is in "Ready to send" status
    #     Then I verify birth tag number "UK 312545 670002" is in "Incomplete" status

    # Scenario: Register a cattle birth open historical registration thats in Pending validation status
    #     And I verify reference number "7KWM-3HTP" is "Pending validation"
    #     And I click on reference number "7KWM-3HTP" from the history registrations
    #     Then I verify the submission details page has:
    #         | Field            | Expected value            |
    #         | Reference number | 7KWM-3HTP                 |
    #         | Submission date  | 22 Sep 2026               |
    #         | Total animals    | 4                         |
    #         | Type             | Cattle birth registration |
    #         | Status           | Pending validation        |
    #     Then I verify the Animals registered table has:
    #         | Ear tag number   | Date of birth | Date on holding | Sex    | Breed |
    #         | UK 123456 301550 | 2 Sep 2026    | 2 Sep 2026      | Male   | HER   |
    #         | UK 123456 301551 | 2 Sep 2026    | 2 Sep 2026      | Female | HER   |
    #         | UK 123456 301552 | 5 Sep 2026    | 5 Sep 2026      | Male   | HER   |
    #         | UK 123456 301553 | 5 Sep 2026    | 5 Sep 2026      | Female | HER   |

    # Scenario: Register a cattle birth open historical registration thats in Approved status
    #     And I verify reference number "M6QA-2JVE" is "Approved"
    #     And I click on reference number "M6QA-2JVE" from the history registrations
    #     Then I verify the submission details page has:
    #         | Field              | Expected value            |
    #         | Reference number   | M6QA-2JVE                 |
    #         | Submission date    | 14 Aug 2026               |
    #         | Total animals      | 3                         |
    #         | Type               | Cattle birth registration |
    #         | Status             | Approved                  |
    #         | Outstanding errors | 1                         |
    #     Then I verify the Animals registered table has:
    #         | Ear tag number   | Date of birth | Date on holding | Sex    | Breed | Errors |
    #         | UK 123456 301543 | 25 Jul 2026   | 25 Jul 2026     | Male   | LIM   | 0      |
    #         | UK 123456 301544 | 28 Jul 2026   | 28 Jul 2026     | Female | LIM   | 1      |
    #         | UK 123456 301545 | 30 Jul 2026   | 30 Jul 2026     | Female | LIM   | 0      |

    Scenario: Register a cattle birth via genetic dam with with sire details and then cancel
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Continue" on the cancellation confirmation page
        Then I am returned to Register new cattle births page

    Scenario: Register a cattle birth via genetic dam with with sire details, cancel and then abort the cancellation
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add sire details with "UK123456501103" and "Sire Name"
        And I cancel the cattle birth registration
        And I select "Cancel" on the cancellation confirmation page
        Then I am returned to Check calf details summary page

    Scenario: Register a cattle birth via genetic dam with no sire details
        And I submit valid calf details with "UK123456301550", "20", "7", "2025", "Male", and "Guernsey (GU)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501101"
        And I add no sire details
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value |
            | Animal ear tag number      | UK123456301550 |
            | Date of birth              | 20 July 2025   |
            | Sex                        | Male           |
            | Breed                      | Guernsey (GU)  |
            | Dam type                   | Genetic        |
            | Genetic dam ear tag number | UK123456501101 |
            | Sire ear tag number        | Not provided   |
            | Sire name                  | Not provided   |
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301550" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "1 cattle birth registered"

    Scenario: Register a cattle birth via surrogate dam with no sire details
        And I submit valid calf details with "UK123456301550", "30", "8", "2025", "Female", and "Heck (HK)"
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456601200"
        And I add no sire details
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value |
            | Animal ear tag number        | UK123456301550 |
            | Date of birth                | 30 August 2025 |
            | Sex                          | Female         |
            | Breed                        | Heck (HK)      |
            | Dam type                     | Surrogate      |
            | Genetic dam ear tag number   | UK123456501101 |
            | Surrogate dam ear tag number | UK123456601200 |
            | Sire ear tag number          | Not provided   |
            | Sire name                    | Not provided   |
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301550" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "1 cattle birth registered"

    Scenario: Register a cattle birth via surrogate dam with sire details
        And I submit valid calf details with "UK123456301550", "3", "9", "2025", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501101" and a surrogate dam ear tag number as "UK123456601200"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK123456301550    |
            | Date of birth                | 3 September 2025  |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK123456501101    |
            | Surrogate dam ear tag number | UK123456601200    |
            | Sire ear tag number          | UK123456501103    |
            | Sire name                    | Sire Name         |
        And I select Continue from the Check calf details page
        And I verify birth tag number "UK123456301550" is "Ready to send"
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "1 cattle birth registered"

    Scenario: Register a cattle birth via surrogate dam then change the surrogate dam ear tag number
        And I submit valid calf details with "UK123456301550", "3", "9", "2025", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501102" and a surrogate dam ear tag number as "UK123456601200"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK123456301550    |
            | Date of birth                | 3 September 2025  |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK123456501102    |
            | Surrogate dam ear tag number | UK123456601200    |
            | Sire ear tag number          | UK123456501103    |
            | Sire name                    | Sire Name         |
        And I change the "Surrogate dam ear tag number" of the calf
        And I add a genetic dam ear tag number as "UK123456501102" and a surrogate dam ear tag number as "UK123456601202"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK123456301550    |
            | Date of birth                | 3 September 2025  |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK123456501102    |
            | Surrogate dam ear tag number | UK123456601202    |
            | Sire ear tag number          | UK123456501103    |
            | Sire name                    | Sire Name         |
        And I select Continue from the Check calf details page
        And I submit "No" for add more animals for births
        And I send my cattle birth report
        Then I verify that "1 cattle birth registered"

    Scenario: Go back from Register cattle birth via genetic dam page and verify entered details remain
        And I submit valid calf details with "UK123456301550", "11", "2", "2025", "Female", and "Baltata Romaneasca (BRO)"
        And I submit the dam details as "calf born via genetic dam"
        And I add the ear tag of the dam as "UK123456501102"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                      | Expected value           |
            | Animal ear tag number      | UK123456301550           |
            | Date of birth              | 11 February 2025         |
            | Sex                        | Female                   |
            | Breed                      | Baltata Romaneasca (BRO) |
            | Dam type                   | Genetic                  |
            | Genetic dam ear tag number | UK123456501102           |
            | Sire ear tag number        | UK123456501103           |
            | Sire name                  | Sire Name                |
        When I select Back from the Check calf details page
        And the previously entered sire details are still populated:
            | Sire ear tag number | UK123456501103 |
            | Sire name           | Sire Name      |
        When I select Back from the Sire details page
        And the previously entered Genetic Dam details are still populated:
            | Genetic dam ear tag number | UK123456501102 |
        When I select Back from the Dam details page
        And the previously entered Dam type "calf born via genetic dam" is still checked:
        When I select Back from the Dam type page
        And the previously entered calf details are still populated:
            | Animal ear tag number | UK123456301550           |
            | Date of birth         | 11/2/2025                |
            | Sex                   | Female                   |
            | Breed                 | Baltata Romaneasca (BRO) |

    Scenario: Go back from Register a cattle birth via surrogate dam and verify entered details remain
        And I submit valid calf details with "UK123456301550", "3", "9", "2025", "Female", and "Irish Moiled (IM)"
        And I submit the dam details as "calf born via surrogate dam"
        And I add a genetic dam ear tag number as "UK123456501102" and a surrogate dam ear tag number as "UK123456601200"
        And I add sire details with "UK123456501103" and "Sire Name"
        Then I verify the Check calf details summary page has:
            | Field                        | Expected value    |
            | Animal ear tag number        | UK123456301550    |
            | Date of birth                | 3 September 2025  |
            | Sex                          | Female            |
            | Breed                        | Irish Moiled (IM) |
            | Dam type                     | Surrogate         |
            | Genetic dam ear tag number   | UK123456501102    |
            | Surrogate dam ear tag number | UK123456601200    |
            | Sire ear tag number          | UK123456501103    |
            | Sire name                    | Sire Name         |
        When I select Back from the Check calf details page
        And the previously entered sire details are still populated:
            | Sire ear tag number | UK123456501103 |
            | Sire name           | Sire Name      |
        When I select Back from the Sire details page
        And the previously entered Surrogate Dam details are still populated:
            | Genetic dam ear tag number   | UK123456501102 |
            | Surrogate dam ear tag number | UK123456601200 |
        When I select Back from the Dam details page
        And the previously entered Dam type "calf born via surrogate dam" is still checked:
        When I select Back from the Dam type page
        And the previously entered calf details are still populated:
            | Animal ear tag number | UK123456301550    |
            | Date of birth         | 3/9/2025          |
            | Sex                   | Female            |
            | Breed                 | Irish Moiled (IM) |