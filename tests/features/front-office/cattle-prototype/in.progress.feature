Feature: Cattle - In Progress - Positive scenarios

    Background: Sign in to the prototype and open In progress
        Given I log into the herokuapp mvp
        When I select "In progress" on the holding overview

    Scenario: Verify the Births tab lists the cattle births in progress
        When I click the "Births" tab
        Then I verify the Births table has:
            | Ear tag number   | Date of birth | Sex    | Breed | Date submitted |
            | UK 123456 301550 | 2 Sep 2026    | Female | HER   | 10 Sep 2026    |
            | UK 123456 301551 | 2 Sep 2026    | Male   | HER   | 10 Sep 2026    |
            | UK 123456 301552 | 5 Sep 2026    | Female | HER   | 10 Sep 2026    |

    # Click on the tag disabled in prototype
    @fixme
    Scenario: Verify selecting an ear tag on the Births tab opens the birth record
        When I click the "Births" tab
        When I click on the "UK 123456 301550" ear tag link
        Then I verify the details

    Scenario: Verify the Movements tab lists the cattle movements in progress
        When I click the "Movements" tab
        Then I verify the Movements table has:
            | Ear tag number   | Movement date | Movement type |
            | UK 324537 113234 | 14 Oct 2026   | Off           |

    # Click on the tag disabled in prototype
    @fixme
    Scenario: Verify selecting an ear tag on the Movements tab opens the movement record
        When I click the "Movements" tab
        When I click on the "UK 324537 113234" ear tag link
        Then I verify the details

    Scenario: Verify the Deaths tab shows a message when no deaths are pending validation
        When I click the "Deaths" tab
        Then I should see the message "There are no deaths pending validation"

    # No deaths records in prototype
    @fixme
    Scenario: Verify selecting an ear tag on the Deaths tab opens the death record
        When I click the "Deaths" tab
        When I click on the "UK 324537 113234" ear tag link
        Then I verify the details