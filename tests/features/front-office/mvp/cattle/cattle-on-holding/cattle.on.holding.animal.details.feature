@ui @frontoffice @dev
Feature: Cattle on holding - View Animals on holding

    @LREG-530
    Scenario: Cattle on holding - View Animals on holding - Single CPH holding - All animals on the holding are listed
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
        And the Animals on Holding caption should display "Oakfield Farm"
        And the Animals on Holding heading should display "Animals on holding"
        And I should be able to search for an animal using ear tag, sex or breed
        And I should see the following Animals on Holding:
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

    Scenario Outline: Cattle on holding - View Animals on holding - Single CPH holding - The table sorts by <column>
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<firstClick>" order
        When I sort the table by "<column>"
        Then the table is sorted by "<column>" in "<secondClick>" order

        # Ear tag number is already sorted ascending when the page loads, so the first click flips it
        Examples:
            | column          | firstClick | secondClick |
            | Ear tag number  | descending | ascending   |
            | Date of birth   | ascending  | descending  |
            | Age             | ascending  | descending  |
            | Date on holding | ascending  | descending  |
            | Sex             | ascending  | descending  |
            | Breed           | ascending  | descending  |

    @LREG-706
    Scenario: Cattle on holding - View Cattle Details - Single CPH holding - Selecting an ear tag shows the animal's cattle details with sire details
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
        And the Animals on Holding caption should display "Oakfield Farm"
        And the Animals on Holding heading should display "Animals on holding"
        And I should be able to search for an animal using ear tag, sex or breed
        And I click on the "UK 200000 000001" ear tag link
        And I should be navigated to the Cattle Details page
        Then I should see the following Cattle Details:
            | Ear tag number   | Date of birth | Date registered | Date on holding | Sex  | Breed               | Animal status | Dam type | Genetic dam ear tag | Sire ear tag     | Sire name    |
            | UK 200000 000001 | 1 Feb 2023    | 5 Feb 2023      | 1 Feb 2023      | Male | Aberdeen Angus (AA) | Active        | Genetic  | UK 200000 000098    | UK 200000 000099 | Not required |

    @LREG-706
    Scenario: Cattle on holding - View Cattle Details - Multiple CPH holdings - Selecting an ear tag shows the animal's cattle details with no sire details recorded
        Given I am authenticated as a front office user with a multiple CPH holding
        And I click the "22/002/0002" CPH number link
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name   | Cattle on holding | In Progress | Cattle Errors |
            | 22/002/0002 | Fairfield Farm | 1                 | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
        And the Animals on Holding caption should display "Fairfield Farm"
        And the Animals on Holding heading should display "Animals on holding"
        And I should be able to search for an animal using ear tag, sex or breed
        And I click on the "UK 200000 000013" ear tag link
        And I should be navigated to the Cattle Details page
        Then I should see the following Cattle Details:
            | Ear tag number   | Date of birth | Date registered | Date on holding | Sex    | Breed            | Animal status | Dam type     | Genetic dam ear tag | Sire details              |
            | UK 200000 000013 | 1 May 2023    | 1 May 2023      | 1 May 2023      | Female | Brown Swiss (BS) | Active        | Not supplied | Not supplied        | No sire details recorded. |

    @LREG-530
    Scenario: Cattle on holding - Search Animals on Holding - Partial ear tag search with more than 25 results is shown across pages
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
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
    Scenario Outline: Cattle on holding - Search Animals on Holding - Ear tag search ignores spaces and letter case - <searchTerm>
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
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
    Scenario Outline: Cattle on holding - Search Animals on Holding - No results message for a search term with no matches - <searchTerm>
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
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
    Scenario: Cattle on holding - Search Animals on Holding - Searching "male" returns only male animals, not female
        Given I am authenticated as a front office user with a single CPH holding
        Then I should see the Cattle overview page with the following details:
            | CPH         | Holding name  | Cattle on holding | In Progress | Cattle Errors |
            | 22/001/0001 | Oakfield Farm | 35                | 0           | 0             |
        When I click the Cattle on holding link
        Then the "Animals on holding" tab should be active
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
