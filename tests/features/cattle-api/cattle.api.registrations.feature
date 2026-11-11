# Registration endpoints, which store bundles in the Cattle API's own database for sending to CTS.
# Only checks that are rejected before anything is saved, so nothing is left behind on CDP dev.
# Each request has every required field (clientReference, holding.cph, submittedBy) except the one under test
@api @cattleapi
Feature: Cattle API - Registrations

    Scenario: Create a registration bundle rejects a request without a client reference
        When I send a POST request to "/v1/registrations" on the Cattle API with:
            """
            {
              "holding": { "cph": "22/001/0001" },
              "submittedBy": "lis-journey-tests",
              "animals": []
            }
            """
        Then the Cattle API responds with status 400

    Scenario: Create a registration bundle rejects a request without a holding
        When I send a POST request to "/v1/registrations" on the Cattle API with:
            """
            {
              "clientReference": "REG-NOHOLDING",
              "submittedBy": "lis-journey-tests",
              "animals": []
            }
            """
        Then the Cattle API responds with status 400

    Scenario: Create a registration bundle rejects a request without a CPH
        When I send a POST request to "/v1/registrations" on the Cattle API with:
            """
            {
              "clientReference": "REG-NOCPH",
              "holding": {},
              "submittedBy": "lis-journey-tests",
              "animals": []
            }
            """
        Then the Cattle API responds with status 400
