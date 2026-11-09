Feature: LIS Front Office - My Profile

    Background: Sign in to the prototype
        Given I log into the herokuapp mvp

    Scenario: Verify the My Profile page shows the user's name, email address and phone number
        When I select the My Profile link
        Then the My Profile page should display the following information:
            | Field name    | Value                |
            | Name          | James Williams       |
            | Email address | jtwilliams@gmail.com |
            | Phone number  | 07700 900000         |