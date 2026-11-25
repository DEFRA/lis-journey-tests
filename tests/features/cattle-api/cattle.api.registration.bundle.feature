# LREG-925: POST /v1/registrations checks the bundle's shape, puts it on the lis_cattle_registration_bundle queue
# and returns 200 straight away. A worker stores the bundle, builds and stores one CTSWeb Birth request,
# sends it and stores the receipt. Part two (LREG-926, polling CTS for the results) is a separate story.
#
# Skipped by default (@skip): rerun these when more of the registration flow is added. They don't need CTS,
# so they run against lis-dev's Cattle API as well as the second one described in cattle.api.cts.status.feature.
#
# Where the rest of LREG-925 is tested:
# - Valid bundle gets 200 with an ID, is stored as submitted, sent to CTS and its receipt stored:
#   cattle.api.cts.status.feature (receipt, sent time and stored Birth request were checked in Postgres, 24 Nov 2026)
# - CTS can't be reached when the bundle is sent: cattle.api.cts.send.failure.feature
#
# Not tested yet, so we don't forget:
# - SQS unavailable returns 503, not 500. Manual only: stop the second API's LocalStack (docker stop
#   cattle-localstack-1), POST a valid bundle, expect 503 with ProblemDetails, then start it again.
# - Messages that keep failing go to the dead-letter queue after 5 attempts, logged with the correlation ID.
#   Not practical: with the 300s visibility timeout it takes about 25 minutes. Left to the dev's tests.
# - With two or more API instances each bundle is processed exactly once, and a redelivered message doesn't
#   create a second bundle or CTS submission. Needs several instances or a redelivered message. Left to the dev's tests.
# - The message is deleted only after the receipt is stored. The queue was empty after the run (24 Nov 2026),
#   but the order can't be seen from outside. Left to the dev's tests.
# - The correlation ID is carried on the SQS message attribute. The worker's logs showed the request's ID
#   (24 Nov 2026), but the message itself wasn't inspected.
#
# Open questions sent to the dev (24 Nov 2026). Update the tests once they're answered:
# - The story left "errored or left for retry" undecided. On CTWS809 (service unavailable) the API tries 3 times,
#   then marks the bundle errored for good, with no later retry. Is that the agreed outcome?
# - An errored bundle's animals stay "submitted". Is that what the BFF should see?
# - GET /v1/holdings/{cph}/bundles doesn't return the bundle's error code or text, so the BFF can't see why
#   it failed (they're only in Postgres). Is that planned?
@skip @api @cattleapi @registrationbundle @LREG-925 @timeout:60000
Feature: Cattle API - Registration bundle submission

    # A rejected bundle must never reach the queue, so this also checks it's never stored
    Scenario: A bundle with no animals is rejected and never stored
        When I send a registration bundle to the Cattle API with:
            """
            {
              "clientReference": "{clientReference}",
              "holding": { "cph": "22/001/0001" },
              "submittedBy": "lis-journey-tests",
              "animals": []
            }
            """
        Then the Cattle API rejects the registration bundle with the error "A registration bundle must contain at least one animal."
        And the bundle is never stored for holding "22/001/0001"

    Scenario: A bundle with a CPH in the wrong form is rejected
        When I send a registration bundle to the Cattle API with:
            """
            {
              "clientReference": "{clientReference}",
              "holding": { "cph": "22-001-0001" },
              "submittedBy": "lis-journey-tests",
              "animals": [
                {
                  "earTag": "UK100000000012",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Female",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                }
              ]
            }
            """
        Then the Cattle API rejects the registration bundle with the error "The holding CPH must be in the form nn/nnn/nnnn."
