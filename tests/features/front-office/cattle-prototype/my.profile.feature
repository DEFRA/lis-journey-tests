Feature: LIS Front Office - My Profile

    Background: Background name: Report a cattle movement
        Given I log into the herokuapp mvp

    Scenario: Verify the My Profile page
        When I select the My Profile link
        Then the My Profile page should display the following information:
            | Field name    | Value                |
            | Name          | James Williams       |
            | Email address | jtwilliams@gmail.com |
            | Phone number  | 07700 900000         |