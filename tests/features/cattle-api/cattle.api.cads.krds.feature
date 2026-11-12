# Checks every Cattle API operation that calls CADS or KRDS still works after their HTTP calls were
# moved onto the Strategy Builders (timeouts added and WithGatewayApiKey replaced by WithDefaultApiKey).
# The timeout values themselves can't be triggered from outside the API, so these are regression checks:
# each operation reaches its upstream service and the upstream response is passed back correctly.
# Test data is the holding and cattle the MVP journey tests use, which exist locally and on CDP dev.
@api @cattleapi @dev
Feature: Cattle API - CADS and KRDS operations

    Scenario Outline: <operation> returns the upstream data
        When I send a GET request to "<path>" on the Cattle API
        Then the Cattle API responds with status 200 and the response contains "<expected>"

        Examples:
            | operation                  | path                                  | expected       |
            | KRDS - holding details     | /v1/holdings/22/001/0001              | Oakfield Farm  |
            | KRDS - holding search      | /v1/holdings?search=22/001/0001       | Oakfield Farm  |
            | CADS - cattle on a holding | /v1/holdings/22/001/0001/cattle       | UK200000000001 |
            | CADS - cattle details      | /v1/cattle/UK200000000001             | UK200000000001 |

    # A 404 shows the request reached the upstream service and its "not found" was passed back,
    # rather than failing on authentication or timing out
    Scenario Outline: <operation> passes back not found from the upstream service
        When I send a GET request to "<path>" on the Cattle API
        Then the Cattle API responds with status 404

        Examples:
            | operation                  | path                                              |
            | KRDS - holding details     | /v1/holdings/99/999/9999                          |
            | KRDS - user details        | /v1/users/00000000-0000-4000-8000-000000000000    |
            | CADS - cattle details      | /v1/cattle/UK999999999999                         |

    # CADS treats a holding it doesn't know as one with no animals, so this is an empty list, not a 404
    Scenario: CADS - cattle on a holding returns an empty list for an unknown holding
        When I send a GET request to "/v1/holdings/99/999/9999/cattle" on the Cattle API
        Then the Cattle API responds with status 200 and the response is "[]"
