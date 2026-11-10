# No Cattle with errors data in mvp
@fixme
Feature: Cattle - Cattle with errors - Positive scenarios

    Background: Sign in to the prototype and open In progress
        Given I am authenticated as a front office user with a single CPH holding
        When I select "Cattle with errors" on the holding overview
        Then I should see the heading "Cattle error record"

    Scenario: Verify the Cattle with errors shows the correct cattle with errors
        Then I verify the Cattle with errors table has:
            | Ear tag number   | Date        | Category                   | Status           |
            | UK 324537 467886 | 11 Aug 2025 | Late registration          | Passport refused |
            | UK 324537 467888 | 13 Aug 2025 | Dam is too young           | Action needed    |
            | UK 324537 467889 | 14 Aug 2025 | Excessive multiple calving | Action needed    |

    Scenario: Verify the embedded links on main cattle error page
        Then I verify the "bcmsenquiries@rpa.gov.uk" email link is present
        Then I verify the "Find out about call charges" link opens the "Call charges and phone numbers" page in a new tab and contains url "call-charges"

    Scenario Outline: Verify the Cattle with errors table sorts by <column>
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<firstClick>" order
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<secondClick>" order

        # Ear tag number is already sorted ascending when the page loads, so the first click flips it
        Examples:
            | column         | firstClick | secondClick |
            | Ear tag number | descending | ascending   |
            | Date           | ascending  | descending  |
            | Category       | ascending  | descending  |
            | Status         | ascending  | descending  |

    Scenario Outline: Verify the error details for <earTag>
        When I click on the "<earTag>" ear tag link
        Then I should see the heading "<earTag>"
        Then I verify the summary list has:
            | Status   | Date raised | Category   | Date of birth | Date of registration | Reason for error |
            | <status> | <raised>    | <category> | <dob>         | <registered>         | <reason>         |
        And the "Information needed" summary row contains "<information>"
        Then I verify the "bcmsenquiries@rpa.gov.uk" email link is present
        Then I verify the "Find out about call charges" link opens the "Call charges and phone numbers" page in a new tab and contains url "call-charges"

        Examples:
            | earTag           | status           | raised      | category                   | dob         | registered  | reason                                                                       | information                                                                                         |
            | UK 324537 467886 | Passport refused | 11 Aug 2025 | Late registration          | 9 Jul 2025  | 10 Aug 2025 | Date of birth is over the 27-day deadline to report a calf birth.            | A Notice of Registration will be sent to your email address.                                        |
            | UK 324537 467888 | Action needed    | 13 Aug 2025 | Dam is too young           | 29 Jul 2025 | 10 Aug 2025 | Genetic/surrogate dam appears to be 12-15 months old at the time of calving. | calving history to prove the ages of the dam and calf by email.                                     |
            | UK 324537 467889 | Action needed    | 14 Aug 2025 | Excessive multiple calving | 30 Jul 2025 | 11 Aug 2025 | Dam has registered three or more calves in the past 240 days                 | The dam you have registered appears to have registered more than three calves in the past 240 days. |


