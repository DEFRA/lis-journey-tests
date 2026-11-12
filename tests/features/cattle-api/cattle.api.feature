@api @cattleapi @dev
Feature: Cattle API

    Scenario: The health check responds without an API key
        When I send a GET request to "/health" on the Cattle API without the API key
        Then the Cattle API responds with status 200

    Scenario: The detailed health check shows the database, queue and scheduler are healthy
        When I send a GET request to "/health/detailed" on the Cattle API without the API key
        Then the Cattle API responds with status 200
        And the Cattle API response field "status" is "Healthy"
        And the Cattle API response contains "database"
        And the Cattle API response contains "queue"
        And the Cattle API response contains "quartz"

    Scenario: The public OpenAPI document is available without an API key
        When I send a GET request to "/openapi/v1.json" on the Cattle API without the API key
        Then the Cattle API responds with status 200

    Scenario: The API key is accepted
        When I send a GET request to "/openapi/v1-internal.json" on the Cattle API
        Then the Cattle API responds with status 200

    Scenario: The internal OpenAPI document needs the API key
        When I send a GET request to "/openapi/v1-internal.json" on the Cattle API without the API key
        Then the Cattle API responds with status 401

    Scenario: A request without the API key is rejected
        When I send a GET request to "/v1/holdings" on the Cattle API without the API key
        Then the Cattle API responds with status 401

    Scenario: A request with an invalid API key is rejected
        When I send a GET request to "/v1/holdings" on the Cattle API with an invalid API key
        Then the Cattle API responds with status 401

    Scenario: A request without a request ID is rejected
        When I send a GET request to "/v1/holdings" on the Cattle API without a request ID
        Then the Cattle API responds with status 400 and the response contains "missing_header"
