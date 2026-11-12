# User endpoints, which read from and write to KRDS.
# Only checks that don't create user accounts, so nothing is left behind on CDP dev
@api @cattleapi @dev
Feature: Cattle API - Users

    Scenario: Get user details rejects a subject that isn't a valid ID
        When I send a GET request to "/v1/users/not-a-uuid" on the Cattle API
        Then the Cattle API responds with status 400

    Scenario: Create a user rejects a request without an email
        When I send a POST request to "/v1/users" on the Cattle API with:
            """
            {
              "sub": "00000000-0000-4000-8000-000000000000",
              "given_name": "FirstName",
              "family_name": "LastName"
            }
            """
        Then the Cattle API responds with status 400
