Feature: Cattle - Activity History - Positive scenarios

    Background: Sign in to the prototype and open Activity history
        Given I log into the herokuapp mvp
        When I select "Activity history" on the holding overview
        Then I verify the Activity page has the CPH number "12/345/0001" and the Holding name "Oakfield Farm"

    Scenario: Verify the Activity history lists the date, activity and reporter of each holding activity
        Then I verify the Activity table has:
            | Date        | Activity                               | Reporter       |
            | 22 Sep 2026 | Cattle birth registration              | James Williams |
            | 17 Sep 2026 | Cattle death report                    | James Williams |
            | 11 Sep 2026 | Cattle off-movement                    | Tom Bennett    |
            | 3 Sep 2026  | Cattle birth registration              | James Williams |
            | 20 Aug 2026 | Cattle on-movement                     | Tom Bennett    |
            | 14 Aug 2026 | Cattle birth registration              | James Williams |
            | 5 Aug 2026  | Delegate added (tony.wilson@gmail.com) | James Williams |

    Scenario: Verify selecting an Activity date shows the submission details and the animals registered
        When I select the "22 Sep 2026" Activity date link
        Then I verify the submission details page has:
            | Field           | Expected value            |
            | Submission date | 22 Sep 2026               |
            | Total animals   | 4                         |
            | Type            | Cattle birth registration |
            | Status          | Pending validation        |
        Then I verify the Animals registered table has:
            | Ear tag number   | Date of birth | Date on holding | Sex    | Breed |
            | UK 123456 301550 | 2 Sep 2026    | 2 Sep 2026      | Male   | HER   |
            | UK 123456 301551 | 2 Sep 2026    | 2 Sep 2026      | Female | HER   |
            | UK 123456 301552 | 5 Sep 2026    | 5 Sep 2026      | Male   | HER   |
            | UK 123456 301553 | 5 Sep 2026    | 5 Sep 2026      | Female | HER   |

    # Animal link disabled in prototype
    @fixme
    Scenario: Verify selecting an ear tag number on the Submission details page shows the animal details
        When I select the "22 Sep 2026" Activity date link
        Then I click on the "UK 123456 301550" ear tag link
        Then I verify the Animals registered table has:
            | Ear tag number   | Date of birth | Date on holding | Sex  | Breed |
            | UK 123456 301550 | 2 Sep 2026    | 2 Sep 2026      | Male | HER   |

