Feature: Cattle -  Report a Cattle Death - Positive scenarios

    Background:
        Given I log into the herokuapp mvp
        When I select Report a cattle death

    Scenario: Report a cattle death for a registered animal
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I click on the tag number "UK123456301550"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for an unregistered animal
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Male", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301550   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Male             |
            | Breed                 | Limousin (LIM)   |
        And I select Continue from the Animal details page
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    # Error - When selecting No to animal registered submission goes to summary rather than animal details page
    Scenario: Report a cattle death for registered animal then change the Registration status from the summary page
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I change the "Animal registered" of the animal
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Male", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301550   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Male             |
            | Breed                 | Limousin (LIM)   |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I select Continue from the Animal details page
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for registered animal then change the Ear tag from the summary page
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I change the "Animal ear tag number" of the animal
        When I submit tag "UK123456301551" and date of death "02/02/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | Yes              |
            | Animal ear tag number | UK123456301551   |
            | Date of death         | 02 February 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for registered animal then change the Date of death from the summary page
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I change the "Date of death" of the animal
        When I submit tag "UK123456301550" and date of death "02/02/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | Yes              |
            | Animal ear tag number | UK123456301550   |
            | Date of death         | 02 February 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I select Continue from the Animal details page
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    # Error - When selecting Yes to animal registered submission goes to summary rather than animal details page
    Scenario: Report a cattle death for unregistered animal then change the Registration status from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Animal registered" of the animal
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301551" and date of death "01/1/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301551  |
            | Date of birth         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for unregistered animal then change the Ear tag from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Animal ear tag number" of the animal
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Female", and "Montbeliarde (MO)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value    |
            | Animal registered     | No                |
            | Animal ear tag number | UK123456301550    |
            | Date of birth         | 11 February 2025  |
            | Date of death         | 01 January 2026   |
            | Sex                   | Female            |
            | Breed                 | Montbeliarde (MO) |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for unregistered animal then change the Date of birth the Breed from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301552", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301552   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Date of birth" of the animal
        And I submit valid animal details with "UK123456301552", "22/3/2025","01/1/2026", "Female", and "Montbeliarde (MO)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value    |
            | Animal registered     | No                |
            | Animal ear tag number | UK123456301552    |
            | Date of birth         | 22 March 2025     |
            | Date of death         | 01 January 2026   |
            | Sex                   | Female            |
            | Breed                 | Montbeliarde (MO) |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301552" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for unregistered animal then change the Date of death from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Date of death" of the animal
        And I submit valid animal details with "UK123456301551", "11/2/2025","09/5/2026", "Female", and "Montbeliarde (MO)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value    |
            | Animal registered     | No                |
            | Animal ear tag number | UK123456301551    |
            | Date of birth         | 11 February 2025  |
            | Date of death         | 09 May 2026       |
            | Sex                   | Female            |
            | Breed                 | Montbeliarde (MO) |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for unregistered animal then change the Sex from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Sex" of the animal
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Male", and "Montbeliarde (MO)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value    |
            | Animal registered     | No                |
            | Animal ear tag number | UK123456301551    |
            | Date of birth         | 11 February 2025  |
            | Date of death         | 01 January 2026   |
            | Sex                   | Male              |
            | Breed                 | Montbeliarde (MO) |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for unregistered animal then change the Breed from the summary page
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I change the "Breed" of the animal
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Montbeliarde (MO)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value    |
            | Animal registered     | No                |
            | Animal ear tag number | UK123456301551    |
            | Date of birth         | 11 February 2025  |
            | Date of death         | 01 January 2026   |
            | Sex                   | Female            |
            | Breed                 | Montbeliarde (MO) |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for a registered animal and add another registered animal
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals for deaths
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301551" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301551  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for a registered animal and add another unregistered animal
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals for deaths
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for a unregistered animal and add another unregistered animal
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301550   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals for deaths
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301551", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301551   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Report a cattle death for a unregistered animal and add another registered animal
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301550   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I submit "Yes" for add more animals for deaths
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301551" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301551  |
            | Date of death         | 01 January 2026 |
        And I select Continue from the Animal details page
        And I verify death tag number "UK123456301550" is "Ready to send"
        And I verify death tag number "UK123456301551" is "Ready to send"
        And I submit "No" for add more animals for deaths
        And I send my cattle death report
        Then I verify that "2 cattle deaths reported"

    Scenario: Go back from the registered animal details summary and verify entered details remain
        When I select "Yes" to is the animal registered
        When I submit tag "UK123456301550" and date of death "01/01/2026"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value  |
            | Animal registered     | Yes             |
            | Animal ear tag number | UK123456301550  |
            | Date of death         | 01 January 2026 |
        When I select Back from the Check animal details page
        And the previously entered registered animal details are still populated:
            | Animal ear tag number | UK123456301550 |
            | Date of death         | 01/01/2026     |

    Scenario: Go back from the unregistered animal details summary and verify entered details remain
        When I select "No" to is the animal registered
        And I submit valid animal details with "UK123456301550", "11/2/2025","01/1/2026", "Female", and "Limousin (LIM)"
        Then I verify the Check animal details summary page has:
            | Field                 | Expected value   |
            | Animal registered     | No               |
            | Animal ear tag number | UK123456301550   |
            | Date of birth         | 11 February 2025 |
            | Date of death         | 01 January 2026  |
            | Sex                   | Female           |
            | Breed                 | Limousin (LIM)   |
        When I select Back from the Check animal details page
        And the previously entered unregistered animal details are still populated:
            | Animal registered     | No             |
            | Animal ear tag number | UK123456301550 |
            | Date of birth         | 11/2/2025      |
            | Date of death         | 01/1/2026      |
            | Sex                   | Female         |
            | Breed                 | Limousin (LIM) |