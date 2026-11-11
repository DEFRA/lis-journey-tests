# Cattle endpoints, which read from CADS.
# Test data is the holding and cattle the MVP journey tests use, which exist locally and on CDP dev.
@api @cattleapi
Feature: Cattle API - Cattle

    Scenario: Get the cattle on a holding
        When I send a GET request to "/v1/holdings/22/001/0001/cattle" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response has 35 items

    Scenario Outline: Filter the cattle on a holding by <filter>
        When I send a GET request to "/v1/holdings/22/001/0001/cattle?<query>" on the Cattle API
        Then the Cattle API responds with status 200
        And every item in the Cattle API response has "<field>" <match> "<value>"

        Examples:
            | filter       | query         | field     | match      | value  |
            | sex female   | sex=female    | sex       | equal to   | female |
            | sex male     | sex=male      | sex       | equal to   | male   |
            | breed code   | breed=AA      | breedCode | equal to   | AA     |
            | ear tag part | earTag=UK2000 | earTag    | containing | UK2000 |

    Scenario: Filter the cattle on a holding by ear tag, breed and sex together
        When I send a GET request to "/v1/holdings/22/001/0001/cattle?earTag=UK2000&breed=AA&sex=female" on the Cattle API
        Then the Cattle API responds with status 200
        And every item in the Cattle API response has "earTag" containing "UK2000"
        And every item in the Cattle API response has "breedCode" equal to "AA"
        And every item in the Cattle API response has "sex" equal to "female"

    Scenario: Filter the cattle on a holding with no match returns an empty list
        When I send a GET request to "/v1/holdings/22/001/0001/cattle?earTag=UK999" on the Cattle API
        Then the Cattle API responds with status 200 and the response is "[]"

    Scenario: Get the details of an animal
        When I send a GET request to "/v1/cattle/UK200000000001" on the Cattle API
        Then the Cattle API responds with status 200
        And the Cattle API response field "earTag" is "UK200000000001"
        And the Cattle API response field "breedCode" is "AA"
        And the Cattle API response field "dateBirth" is "2023-02-01"
        And the Cattle API response field "geneticDamEarTag" is "UK200000000098"
        And the Cattle API response field "sireEarTag" is "UK200000000099"
