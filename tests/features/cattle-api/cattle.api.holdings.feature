# Holding endpoints. Holding details and search come from KRDS, cattle from CADS and
# bundles from the Cattle API's own database.
# Test data is the holding the MVP journey tests use, which exists locally and on CDP dev.
@api @cattleapi
Feature: Cattle API - Holdings

    Scenario: Search holdings by name
        When I send a GET request to "/v1/holdings?search=Oakfield" on the Cattle API
        Then the Cattle API responds with status 200 and the response contains "22/001/0001"

    # Spaces are sent as %20
    Scenario Outline: Search holdings by <case>
        When I send a GET request to "/v1/holdings?search=<search>" on the Cattle API
        Then the Cattle API responds with status 200 and the response contains "22/001/0001"

        Examples:
            | case                     | search          |
            | CPH                      | 22/001/0001     |
            | CPH without slashes      | 220010001       |
            | CPH with spaces          | 22%20001%200001 |
            | postcode                 | SY4%201AB       |
            | postcode without a space | SY41AB          |
            | herd mark                | UK%20324537     |
            | herd mark number only    | 324537          |

    Scenario: Search holdings with no match returns an empty page
        When I send a GET request to "/v1/holdings?search=Nomatchfarmxyz" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response field "totalCount" is "0"

    Scenario: Search holdings returns the requested page
        When I send a GET request to "/v1/holdings?page=1&pageSize=2" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response field "page" is "1"
        And the Cattle API response field "pageSize" is "2"
        And the Cattle API response field "hasPreviousPage" is "false"
        And the Cattle API response has 2 items

    Scenario: Search holdings returns the second page
        When I send a GET request to "/v1/holdings?page=2&pageSize=2" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response field "page" is "2"
        And the Cattle API response field "hasPreviousPage" is "true"
        And the Cattle API response has 2 items

    # "order" is the field to sort by and "sort" is the direction
    Scenario Outline: Search holdings sorted by CPH in <direction> order
        When I send a GET request to "/v1/holdings?order=cph&sort=<sort>&pageSize=10" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response items are sorted by "cph" in "<direction>" order

        Examples:
            | sort | direction  |
            | asc  | ascending  |
            | desc | descending |

    Scenario Outline: Search holdings rejects <problem>
        When I send a GET request to "/v1/holdings?<query>" on the Cattle API
        Then the Cattle API responds with status 400 and the response contains "<message>"

        Examples:
            | problem              | query                | message                                       |
            | a page below 1       | page=0               | Page must be greater than or equal to 1.      |
            | a page size below 1  | pageSize=0           | Page size must be between 1 and 100.          |
            | a page size over 100 | pageSize=101         | Page size must be between 1 and 100.          |
            | an unknown sort      | sort=up              | Sort must be either                           |
            | an unknown order     | order=colour         | Order must be one of                          |
            | invalid characters   | search=%3Cscript%3E  | Search contains invalid characters.           |

    Scenario: Get the details of a holding
        When I send a GET request to "/v1/holdings/22/001/0001" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response field "cph" is "22/001/0001"
        And the Cattle API response field "name" is "Oakfield Farm"
        And the Cattle API response contains "SY4 1AB"
        And the Cattle API response contains "UK 324537"

    Scenario Outline: Get holding details rejects a CPH whose <segment> is the wrong length
        When I send a GET request to "/v1/holdings/<cph>" on the Cattle API
        Then the Cattle API responds with status 400 and the response contains "<message>"

        Examples:
            | segment | cph         | message           |
            | county  | 2/001/0001  | must be 2 digits  |
            | parish  | 22/01/0001  | must be 3 digits  |
            | holding | 22/001/001  | must be 4 digits  |

    Scenario: Get the bundles for a holding
        When I send a GET request to "/v1/holdings/22/001/0001/bundles" on the Cattle API
        Then the Cattle API responds with status 200

    # Bundles are the Cattle API's own records, so a holding with none is an empty list, not a 404
    Scenario: Get the bundles for a holding with no bundles
        When I send a GET request to "/v1/holdings/99/999/9999/bundles" on the Cattle API
        Then the Cattle API responds with status 200 and the response is "[]"

    Scenario Outline: Search holdings allows up to 200 characters - <length> characters
        When I search holdings on the Cattle API with <length> characters
        Then the Cattle API responds with status <status> and the response contains "<expected>"

        Examples:
            | length | status | expected                             |
            | 200    | 200    | totalCount                           |
            | 201    | 400    | Search cannot exceed 200 characters. |
