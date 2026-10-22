Feature: Cattle -  Report a Cattle Movement - Positive scenarios

    Background: Background name: Report a cattle movement
        Given I log into the herokuapp mvp
        When I select Report a cattle movement

    Scenario: Report multiple cattle On Movements
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301551 | 21/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                       |
            | Movement type | On movement                          |
            | Animal 1      | UK123456301550 Moved 1 January 2025  |
            | Animal 2      | UK123456301551 Moved 21 October 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Report multiple cattle Off movements
        When I select "Off movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
            | UK324537113236 | 21/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                       |
            | Movement type | Off movement                         |
            | Animal 1      | UK324537113235 Moved 1 January 2025  |
            | Animal 2      | UK324537113236 Moved 21 October 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Change Movement type from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I select change for "Movement type"
        When I select "Off movement" and continue
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | Off movement                        |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Change Animal Ear Tag from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I select change for "Animal 1"
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113236 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK324537113236 Moved 1 January 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Change Movement date from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I select change for "Animal 1"
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 11/11/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                        |
            | Movement type | On movement                           |
            | Animal 1      | UK324537113235 Moved 11 November 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Add an extra animal from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I select change for "Animal 1"
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 11/11/2025    |
            | UK324537113236 | 10/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                        |
            | Movement type | On movement                           |
            | Animal 1      | UK324537113235 Moved 11 November 2025 |
            | Animal 2      | UK324537113236 Moved 10 October 2025  |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Remove an extra animal from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301551 | 21/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                       |
            | Movement type | On movement                          |
            | Animal 1      | UK123456301550 Moved 1 January 2025  |
            | Animal 2      | UK123456301551 Moved 21 October 2025 |
        When I select change for "Animal 1"
        When I remove "Animal 2"
        When I continue from Movement details page
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK123456301550 Moved 1 January 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Report a single cattle On movement
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | On movement                         |
            | Animal 1      | UK123456301550 Moved 1 January 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Report a single cattle Off movement
        When I select "Off movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK324537113235 | 01/01/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                      |
            | Movement type | Off movement                        |
            | Animal 1      | UK324537113235 Moved 1 January 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported

    Scenario: Change Animal 2 from Check Movement details page
        When I select "On movement" and continue
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301551 | 21/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                       |
            | Movement type | On movement                          |
            | Animal 1      | UK123456301550 Moved 1 January 2025  |
            | Animal 2      | UK123456301551 Moved 21 October 2025 |
        When I select change for "Animal 2"
        When I submit movement details
            | Ear tag number | Movement date |
            | UK123456301550 | 01/01/2025    |
            | UK123456301552 | 21/10/2025    |
        When I verify the Check movement details page displays the following details
            | Field         | Expected value                       |
            | Movement type | On movement                          |
            | Animal 1      | UK123456301550 Moved 1 January 2025  |
            | Animal 2      | UK123456301552 Moved 21 October 2025 |
        When I continue from Check movement details page
        When I send my movement report
        Then I confirm the Movement has been reported
