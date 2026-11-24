# Submission endpoints of the cattle register BFF (lis-be4fe-cattle-register), which the
# register a cattle birth journey uses to keep a draft for a holding.
# Locally the BFF runs in the lis-dev stack on port 8089 (LIS_CATTLE_REGISTER_BFF_BASE_URL).
# Uses holding 03/202/0021 and its unallocated ear tags UK324798100001-10, which no other test
# uses, so these drafts can't clash with the browser journeys on 22/001/0001.
# A holding has one draft at a time, so the scenarios run one after another (@mode:default).
# Unlike @mode:serial, a failing scenario doesn't skip the ones after it, as none depends on another.
# Each animal saved is deleted when its test ends. The draft itself stays (there is no endpoint
# to delete it) and is continued by the next run.
# Submitting a draft (POST /submission/{cph}/{id}) isn't tested: it sends the bundle to the
# Cattle API, whose registrations endpoint isn't ready yet
@api @cattleregisterbff @dev @mode:default
Feature: Cattle register BFF - Submissions

    Scenario: The health check responds without an API key
        When I send a GET request to "/health" on the cattle register BFF without the API key
        Then the cattle register BFF responds with status 200

    Scenario: A request without the API key is rejected
        When I send a GET request to "/submission/03/202/0021" on the cattle register BFF without the API key
        Then the cattle register BFF responds with status 401

    Scenario: A request with an invalid API key is rejected
        When I send a GET request to "/submission/03/202/0021" on the cattle register BFF with an invalid API key
        Then the cattle register BFF responds with status 401

    Scenario: A request without a request ID is rejected
        When I send a GET request to "/submission/03/202/0021" on the cattle register BFF without a request ID
        Then the cattle register BFF responds with status 400
        And the cattle register BFF response contains "x-cdp-request-id"

    Scenario: List the submissions for a holding
        When I send a GET request to "/submission/03/202/0021" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        And the cattle register BFF response contains "submissions"

    Scenario: Starting a submission again continues the same draft
        Given I start a submission for "03/202/0021" on the cattle register BFF
        When I send a GET request to "/submission/03/202/0021/start" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        And the cattle register BFF response field "submission-id" is "{submissionId}"

    Scenario: Get a started submission
        Given I start a submission for "03/202/0021" on the cattle register BFF
        When I send a GET request to "/submission/03/202/0021/{submissionId}" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        And the cattle register BFF response field "submission-id" is "{submissionId}"

    Scenario: A saved animal can be read back
        Given I start a submission for "03/202/0021" on the cattle register BFF
        And I save animal "UK324798100001" to the submission for "03/202/0021" on the cattle register BFF with:
            """
            {
              "status": "draft",
              "data": [
                { "key": "sex", "value": "Female", "type": "string" },
                { "key": "breed", "value": "Danish Red (DR)", "type": "string" }
              ]
            }
            """
        When I send a GET request to "/submission/03/202/0021/{submissionId}/UK324798100001" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        And the cattle register BFF response field "animal-id" is "UK324798100001"
        And the cattle register BFF response field "status" is "draft"
        And the cattle register BFF response field "data.0.key" is "sex"
        And the cattle register BFF response field "data.0.value" is "Female"
        And the cattle register BFF response field "data.1.value" is "Danish Red (DR)"

    Scenario: A saved animal is listed in the submission
        Given I start a submission for "03/202/0021" on the cattle register BFF
        And I save animal "UK324798100002" to the submission for "03/202/0021" on the cattle register BFF with:
            """
            {
              "status": "draft",
              "data": [{ "key": "sex", "value": "Male", "type": "string" }]
            }
            """
        When I send a GET request to "/submission/03/202/0021/{submissionId}" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        And the cattle register BFF response contains "UK324798100002"

    Scenario: Updating a saved animal changes its data and status
        Given I start a submission for "03/202/0021" on the cattle register BFF
        And I save animal "UK324798100003" to the submission for "03/202/0021" on the cattle register BFF with:
            """
            {
              "status": "draft",
              "data": [{ "key": "sex", "value": "Male", "type": "string" }]
            }
            """
        When I send a PATCH request to "/submission/03/202/0021/{submissionId}/UK324798100003" on the cattle register BFF with:
            """
            {
              "status": "complete",
              "data": [{ "key": "sex", "value": "Female", "type": "string" }]
            }
            """
        Then the cattle register BFF responds with status 200
        When I send a GET request to "/submission/03/202/0021/{submissionId}/UK324798100003" on the cattle register BFF
        Then the cattle register BFF response field "status" is "complete"
        And the cattle register BFF response field "data.0.value" is "Female"

    Scenario: A removed animal can no longer be read
        Given I start a submission for "03/202/0021" on the cattle register BFF
        And I save animal "UK324798100004" to the submission for "03/202/0021" on the cattle register BFF with:
            """
            {
              "status": "draft",
              "data": [{ "key": "sex", "value": "Male", "type": "string" }]
            }
            """
        When I send a DELETE request to "/submission/03/202/0021/{submissionId}/UK324798100004" on the cattle register BFF
        Then the cattle register BFF responds with status 200
        When I send a GET request to "/submission/03/202/0021/{submissionId}/UK324798100004" on the cattle register BFF
        Then the cattle register BFF responds with status 404

    Scenario: Saving an animal without a status is rejected
        Given I start a submission for "03/202/0021" on the cattle register BFF
        When I send a POST request to "/submission/03/202/0021/{submissionId}/UK324798100005" on the cattle register BFF with:
            """
            {
              "data": [{ "key": "sex", "value": "Male", "type": "string" }]
            }
            """
        Then the cattle register BFF responds with status 400

    Scenario: Getting an animal that isn't in the submission returns not found
        Given I start a submission for "03/202/0021" on the cattle register BFF
        When I send a GET request to "/submission/03/202/0021/{submissionId}/UK324798100010" on the cattle register BFF
        Then the cattle register BFF responds with status 404

    Scenario: Getting a submission that doesn't exist returns not found
        When I send a GET request to "/submission/03/202/0021/00000000-0000-0000-0000-000000000000" on the cattle register BFF
        Then the cattle register BFF responds with status 404
