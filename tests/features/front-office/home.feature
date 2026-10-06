@ui @frontoffice
Feature: LIS Front Office Home Page

    @accessibility @dev
    Scenario: Home Page
        Given I am on the LIS Front Office home page
        Then the unauthenticated LIS Front Office home page should be loaded correctly
        And the LIS Front Office home page should be accessible

    @LREG-531
    Scenario: Cattle Home - View Holding Details - No CPH holdings
        Given I am authenticated as a front office user with no CPH holding
        Then I should be informed I have no holdings associated to my account

    @LREG-531
    Scenario: Cattle Home - View Holding Details - Multiple CPH holdings
        Given I am authenticated as a front office user with multiple CPH holdings
        Then I should see the following CPH holdings:
            | CPH         | Holding name   | Postcode     | Role  |
            | 22/002/0002 | Fairfield Farm | Not supplied | Owner |
            | 22/003/0003 | Not supplied   | Not supplied | Owner |
            | 22/004/0004 | Hilltop Farm   | Not supplied | Owner |
            | 22/005/0005 | Riverside Farm | Not supplied | Owner |
            | 22/006/0006 | Long Acre Farm | Not supplied | Owner |
            | 22/007/0007 | Orchard Farm   | Not supplied | Owner |

    @LREG-531
    Scenario: Cattle Home - View Holding Details - Single CPH holding
        Given I am authenticated as a front office user with a single CPH holding
        Then the "Holding details" navigation link should be active
        And the holding details caption should display "Oakfield Farm"
        And the holding details heading should display "Holding details"
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name  | Address                                                    | Herd mark |
            | 22/001/0001 | Oakfield Farm | Oakfield FarmChurch LaneShrewsburyShropshireSY4 1ABEngland | UK 324537 |

    @LREG-531
    Scenario: Cattle Home - View Holding Details - Multiple CPH holding - Display CPH number as caption when holding name is missing
        Given I am authenticated as a front office user with a multiple CPH holding
        When I navigate to the "cattle" holdings detail page for the CPH "22/003/0003"
        Then the holding details caption should display "22/003/0003"
        And I should see the following holding details for the CPH:
            | CPH number  | Holding name | Address                                                        | Herd mark |
            | 22/003/0003 | Not supplied | Meadow View FarmMill LaneLavendonBuckinghamshireMK1 1ABEngland | UK 324788 |

    @LREG-531
    Scenario: Cattle Home - View Holding Details - Single CPH holding - Should not be able to see any other holding that is not associated
        Given I am authenticated as a front office user with a single CPH holding
        When I navigate to the "cattle" holdings detail page for the CPH "22/003/0003"
        Then I should not be able to view the CPH holding

    @LREG-530
    Scenario: Cattle Home - View Animals on Holding - Single CPH holding
        Given I am authenticated as a front office user with a single CPH holding
        And the "Holding details" navigation link is active
        When I select the "Animals on holding" navigation link
        Then the "Animals on holding" navigation link should be active
        And the animals on holding caption should display "Oakfield Farm"
        And the animals on holding heading should display "Animals on holding"
        And I should be able to search for an animal using ear tag, sex or breed
        And I should see the following animals on holding:
            | Ear tag number   | Date of birth | Age                             | Date on holding | Sex    | Breed                        |
            | UK 200000 000001 | 1 Feb 2023    | formatDateYearMonth:1 Feb 2023  | 1 Feb 2023      | Male   | AA, Aberdeen Angus           |
            | UK 200000 000002 | 8 Feb 2023    | formatDateYearMonth:8 Feb 2023  | 8 Feb 2023      | Male   | HE, Hereford                 |
            | UK 200000 000003 | 15 Feb 2023   | formatDateYearMonth:15 Feb 2023 | 15 Feb 2023     | Male   | CH, Charolais                |
            | UK 200000 000004 | 22 Feb 2023   | formatDateYearMonth:22 Feb 2023 | 22 Feb 2023     | Male   | LIM, Limousin                |
            | UK 200000 000005 | 1 Mar 2023    | formatDateYearMonth:1 Mar 2023  | 1 Mar 2023      | Male   | SM, Simmental                |
            | UK 200000 000006 | 8 Mar 2023    | formatDateYearMonth:8 Mar 2023  | 8 Mar 2023      | Male   | GA, Galloway                 |
            | UK 200000 000007 | 15 Mar 2023   | formatDateYearMonth:15 Mar 2023 | 15 Mar 2023     | Female | HI, Highland                 |
            | UK 200000 000008 | 22 Mar 2023   | formatDateYearMonth:22 Mar 2023 | 22 Mar 2023     | Female | HF, Holstein Friesian        |
            | UK 200000 000009 | 1 Apr 2023    | formatDateYearMonth:1 Apr 2023  | 1 Apr 2023      | Female | HO, Holstein                 |
            | UK 200000 000010 | 8 Apr 2023    | formatDateYearMonth:8 Apr 2023  | 8 Apr 2023      | Female | JE, Jersey                   |
            | UK 200000 000011 | 15 Apr 2023   | formatDateYearMonth:15 Apr 2023 | 15 Apr 2023     | Female | AY, Ayrshire                 |
            | UK 200000 000012 | 22 Apr 2023   | formatDateYearMonth:22 Apr 2023 | 22 Apr 2023     | Female | GU, Guernsey                 |
            | UK 300000 000002 | 1 Jan 2020    | formatDateYearMonth:1 Jan 2020  | 1 Jan 2020      | Female | HF, Holstein Friesian        |
            | UK 300000 000003 | 1 Jan 2020    | formatDateYearMonth:1 Jan 2020  | 1 Jan 2020      | Female | HF, Holstein Friesian        |
            | UK 300000 000004 | 1 Jun 2026    | formatDateYearMonth:1 Jun 2026  | 1 Jun 2026      | Female | HF, Holstein Friesian        |
            | UK 300000 000005 | 1 Jan 1990    | formatDateYearMonth:1 Jan 1990  | 1 Jan 1990      | Female | HF, Holstein Friesian        |
            | UK 300000 000006 | 14 May 2022   | formatDateYearMonth:14 May 2022 | 14 May 2022     | Male   | DEX, Dexter                  |
            | UK 300000 000007 | 2 Jun 2022    | formatDateYearMonth:2 Jun 2022  | 2 Jun 2022      | Female | LH, Longhorn                 |
            | UK 300000 000008 | 19 Jul 2022   | formatDateYearMonth:19 Jul 2022 | 19 Jul 2022     | Male   | WB, Welsh Black              |
            | UK 300000 000009 | 3 Sep 2022    | formatDateYearMonth:3 Sep 2022  | 3 Sep 2022      | Female | SU, Sussex                   |
            | UK 300000 000010 | 21 Oct 2022   | formatDateYearMonth:21 Oct 2022 | 21 Oct 2022     | Male   | RP, Red Poll                 |
            | UK 300000 000011 | 8 Dec 2022    | formatDateYearMonth:8 Dec 2022  | 8 Dec 2022      | Female | SD, South Devon              |
            | UK 300000 000012 | 26 Jan 2023   | formatDateYearMonth:26 Jan 2023 | 26 Jan 2023     | Male   | BSH, Beef Shorthorn          |
            | UK 300000 000013 | 11 May 2023   | formatDateYearMonth:11 May 2023 | 11 May 2023     | Female | NO, Normande                 |
            | UK 300000 000014 | 29 Jun 2023   | formatDateYearMonth:29 Jun 2023 | 29 Jun 2023     | Male   | MO, Montbeliarde             |
            | UK 300000 000015 | 17 Aug 2023   | formatDateYearMonth:17 Aug 2023 | 17 Aug 2023     | Female | BS, Brown Swiss              |
            | UK 300000 000016 | 4 Nov 2023    | formatDateYearMonth:4 Nov 2023  | 4 Nov 2023      | Male   | BRB, British Blue            |
            | UK 300000 000017 | 22 Jan 2024   | formatDateYearMonth:22 Jan 2024 | 22 Jan 2024     | Female | LR, Lincoln Red              |
            | UK 300000 000018 | 9 Mar 2024    | formatDateYearMonth:9 Mar 2024  | 9 Mar 2024      | Male   | CB, Cross Breed Beef         |
            | UK 300000 000019 | 27 May 2024   | formatDateYearMonth:27 May 2024 | 27 May 2024     | Female | CD, Cross Breed Dairy        |
            | UK 300000 000020 | 14 Aug 2024   | formatDateYearMonth:14 Aug 2024 | 14 Aug 2024     | Male   | OD, Other Dairy              |
            | UK 300000 000021 | 2 Oct 2024    | formatDateYearMonth:2 Oct 2024  | 2 Oct 2024      | Female | AA, Aberdeen Angus           |
            | UK 300000 000022 | 19 Dec 2024   | formatDateYearMonth:19 Dec 2024 | 19 Dec 2024     | Male   | CH, Charolais                |
            | UK 300000 000023 | 6 Feb 2025    | formatDateYearMonth:6 Feb 2025  | 6 Feb 2025      | Female | LIM, Limousin                |
            | UK 300000 000024 | 11 Apr 2025   | formatDateYearMonth:11 Apr 2025 | 11 Apr 2025     | Male   | HFX, Holstein Friesian Cross |

    @LREG-530
    Scenario: Cattle Home - Search Animals on Holding - Result greater than 25 items
        Given I am authenticated as a front office user with a single CPH holding
        When I select the "Animals on holding" navigation link
        And I search using search term '00000'
        Then I should see the following search results for '00000':
            | Ear tag number   | Date of birth | Age                             | Date on holding | Sex    | Breed                        |
            | UK 200000 000001 | 1 Feb 2023    | formatDateYearMonth:1 Feb 2023  | 1 Feb 2023      | Male   | AA, Aberdeen Angus           |
            | UK 200000 000002 | 8 Feb 2023    | formatDateYearMonth:8 Feb 2023  | 8 Feb 2023      | Male   | HE, Hereford                 |
            | UK 200000 000003 | 15 Feb 2023   | formatDateYearMonth:15 Feb 2023 | 15 Feb 2023     | Male   | CH, Charolais                |
            | UK 200000 000004 | 22 Feb 2023   | formatDateYearMonth:22 Feb 2023 | 22 Feb 2023     | Male   | LIM, Limousin                |
            | UK 200000 000005 | 1 Mar 2023    | formatDateYearMonth:1 Mar 2023  | 1 Mar 2023      | Male   | SM, Simmental                |
            | UK 200000 000006 | 8 Mar 2023    | formatDateYearMonth:8 Mar 2023  | 8 Mar 2023      | Male   | GA, Galloway                 |
            | UK 200000 000007 | 15 Mar 2023   | formatDateYearMonth:15 Mar 2023 | 15 Mar 2023     | Female | HI, Highland                 |
            | UK 200000 000008 | 22 Mar 2023   | formatDateYearMonth:22 Mar 2023 | 22 Mar 2023     | Female | HF, Holstein Friesian        |
            | UK 200000 000009 | 1 Apr 2023    | formatDateYearMonth:1 Apr 2023  | 1 Apr 2023      | Female | HO, Holstein                 |
            | UK 200000 000010 | 8 Apr 2023    | formatDateYearMonth:8 Apr 2023  | 8 Apr 2023      | Female | JE, Jersey                   |
            | UK 200000 000011 | 15 Apr 2023   | formatDateYearMonth:15 Apr 2023 | 15 Apr 2023     | Female | AY, Ayrshire                 |
            | UK 200000 000012 | 22 Apr 2023   | formatDateYearMonth:22 Apr 2023 | 22 Apr 2023     | Female | GU, Guernsey                 |
            | UK 300000 000002 | 1 Jan 2020    | formatDateYearMonth:1 Jan 2020  | 1 Jan 2020      | Female | HF, Holstein Friesian        |
            | UK 300000 000003 | 1 Jan 2020    | formatDateYearMonth:1 Jan 2020  | 1 Jan 2020      | Female | HF, Holstein Friesian        |
            | UK 300000 000004 | 1 Jun 2026    | formatDateYearMonth:1 Jun 2026  | 1 Jun 2026      | Female | HF, Holstein Friesian        |
            | UK 300000 000005 | 1 Jan 1990    | formatDateYearMonth:1 Jan 1990  | 1 Jan 1990      | Female | HF, Holstein Friesian        |
            | UK 300000 000006 | 14 May 2022   | formatDateYearMonth:14 May 2022 | 14 May 2022     | Male   | DEX, Dexter                  |
            | UK 300000 000007 | 2 Jun 2022    | formatDateYearMonth:2 Jun 2022  | 2 Jun 2022      | Female | LH, Longhorn                 |
            | UK 300000 000008 | 19 Jul 2022   | formatDateYearMonth:19 Jul 2022 | 19 Jul 2022     | Male   | WB, Welsh Black              |
            | UK 300000 000009 | 3 Sep 2022    | formatDateYearMonth:3 Sep 2022  | 3 Sep 2022      | Female | SU, Sussex                   |
            | UK 300000 000010 | 21 Oct 2022   | formatDateYearMonth:21 Oct 2022 | 21 Oct 2022     | Male   | RP, Red Poll                 |
            | UK 300000 000011 | 8 Dec 2022    | formatDateYearMonth:8 Dec 2022  | 8 Dec 2022      | Female | SD, South Devon              |
            | UK 300000 000012 | 26 Jan 2023   | formatDateYearMonth:26 Jan 2023 | 26 Jan 2023     | Male   | BSH, Beef Shorthorn          |
            | UK 300000 000013 | 11 May 2023   | formatDateYearMonth:11 May 2023 | 11 May 2023     | Female | NO, Normande                 |
            | UK 300000 000014 | 29 Jun 2023   | formatDateYearMonth:29 Jun 2023 | 29 Jun 2023     | Male   | MO, Montbeliarde             |
            | UK 300000 000015 | 17 Aug 2023   | formatDateYearMonth:17 Aug 2023 | 17 Aug 2023     | Female | BS, Brown Swiss              |
            | UK 300000 000016 | 4 Nov 2023    | formatDateYearMonth:4 Nov 2023  | 4 Nov 2023      | Male   | BRB, British Blue            |
            | UK 300000 000017 | 22 Jan 2024   | formatDateYearMonth:22 Jan 2024 | 22 Jan 2024     | Female | LR, Lincoln Red              |
            | UK 300000 000018 | 9 Mar 2024    | formatDateYearMonth:9 Mar 2024  | 9 Mar 2024      | Male   | CB, Cross Breed Beef         |
            | UK 300000 000019 | 27 May 2024   | formatDateYearMonth:27 May 2024 | 27 May 2024     | Female | CD, Cross Breed Dairy        |
            | UK 300000 000020 | 14 Aug 2024   | formatDateYearMonth:14 Aug 2024 | 14 Aug 2024     | Male   | OD, Other Dairy              |
            | UK 300000 000021 | 2 Oct 2024    | formatDateYearMonth:2 Oct 2024  | 2 Oct 2024      | Female | AA, Aberdeen Angus           |
            | UK 300000 000022 | 19 Dec 2024   | formatDateYearMonth:19 Dec 2024 | 19 Dec 2024     | Male   | CH, Charolais                |
            | UK 300000 000023 | 6 Feb 2025    | formatDateYearMonth:6 Feb 2025  | 6 Feb 2025      | Female | LIM, Limousin                |
            | UK 300000 000024 | 11 Apr 2025   | formatDateYearMonth:11 Apr 2025 | 11 Apr 2025     | Male   | HFX, Holstein Friesian Cross |

    @LREG-530
    Scenario Outline: Cattle Home - Search Animals on Holding using search term <searchTerm> - Result less than 25
        Given I am authenticated as a front office user with a single CPH holding
        When I select the "Animals on holding" navigation link
        And I search using search term '<searchTerm>'
        Then I should see the following search results for '<searchTerm>':
            | Ear tag number   | Date of birth | Age                            | Date on holding | Sex  | Breed              |
            | UK 200000 000001 | 1 Feb 2023    | formatDateYearMonth:1 Feb 2023 | 1 Feb 2023      | Male | AA, Aberdeen Angus |
        Examples: Ear tag numbers
            | searchTerm       |
            | UK200000 000001  |
            | UK 200000000001  |
            | uk 200000 000001 |
            | UK200000000001   |

    @LREG-530
    Scenario Outline: Cattle Home - Search animals on holding using search term <searchTerm> - no result returned
        Given I am authenticated as a front office user with a single CPH holding
        When I select the "Animals on holding" navigation link
        And I search using search term '<searchTerm>'
        Then I should see no results returned for search term '<searchTerm>'
        Examples: Search terms that return no result
            | searchTerm |
            | !@£$%^&*() |
            | 099999     |
            | ABXXYD     |
            | fe male    |
            | ma le      |

    @LREG-530
    Scenario: Cattle Home - Search animales on holding using sex matches full sex not partial
        Given I am authenticated as a front office user with a single CPH holding
        When I select the "Animals on holding" navigation link
        And I search using search term 'male'
        Then I should see the following search results for 'male':
            | Ear tag number   | Date of birth | Age                             | Date on holding | Sex  | Breed                        |
            | UK 200000 000001 | 1 Feb 2023    | formatDateYearMonth:1 Feb 2023  | 1 Feb 2023      | Male | AA, Aberdeen Angus           |
            | UK 200000 000002 | 8 Feb 2023    | formatDateYearMonth:8 Feb 2023  | 8 Feb 2023      | Male | HE, Hereford                 |
            | UK 200000 000003 | 15 Feb 2023   | formatDateYearMonth:15 Feb 2023 | 15 Feb 2023     | Male | CH, Charolais                |
            | UK 200000 000004 | 22 Feb 2023   | formatDateYearMonth:22 Feb 2023 | 22 Feb 2023     | Male | LIM, Limousin                |
            | UK 200000 000005 | 1 Mar 2023    | formatDateYearMonth:1 Mar 2023  | 1 Mar 2023      | Male | SM, Simmental                |
            | UK 200000 000006 | 8 Mar 2023    | formatDateYearMonth:8 Mar 2023  | 8 Mar 2023      | Male | GA, Galloway                 |
            | UK 300000 000006 | 14 May 2022   | formatDateYearMonth:14 May 2022 | 14 May 2022     | Male | DEX, Dexter                  |
            | UK 300000 000008 | 19 Jul 2022   | formatDateYearMonth:19 Jul 2022 | 19 Jul 2022     | Male | WB, Welsh Black              |
            | UK 300000 000010 | 21 Oct 2022   | formatDateYearMonth:21 Oct 2022 | 21 Oct 2022     | Male | RP, Red Poll                 |
            | UK 300000 000012 | 26 Jan 2023   | formatDateYearMonth:26 Jan 2023 | 26 Jan 2023     | Male | BSH, Beef Shorthorn          |
            | UK 300000 000014 | 29 Jun 2023   | formatDateYearMonth:29 Jun 2023 | 29 Jun 2023     | Male | MO, Montbeliarde             |
            | UK 300000 000016 | 4 Nov 2023    | formatDateYearMonth:4 Nov 2023  | 4 Nov 2023      | Male | BRB, British Blue            |
            | UK 300000 000018 | 9 Mar 2024    | formatDateYearMonth:9 Mar 2024  | 9 Mar 2024      | Male | CB, Cross Breed Beef         |
            | UK 300000 000020 | 14 Aug 2024   | formatDateYearMonth:14 Aug 2024 | 14 Aug 2024     | Male | OD, Other Dairy              |
            | UK 300000 000022 | 19 Dec 2024   | formatDateYearMonth:19 Dec 2024 | 19 Dec 2024     | Male | CH, Charolais                |
            | UK 300000 000024 | 11 Apr 2025   | formatDateYearMonth:11 Apr 2025 | 11 Apr 2025     | Male | HFX, Holstein Friesian Cross |
