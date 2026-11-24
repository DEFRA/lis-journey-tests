# LREG-925: if CTS can't be reached when a bundle is sent, the bundle is marked as errored and never looks as if
# it was sent. The API tries CTS 3 times (about 3 seconds), then marks the bundle "error" with no receipt.
# The story left "errored or left for retry" as a decision; this checks the current behaviour (errored).
#
# A one-off check, skipped by default (@skip). It runs against the second Cattle API, the same way as
# cattle.api.cts.status.feature (see the steps there), with one difference: set
# CTS_WS_SERVICE_UNAVAILABLE_PROBABILITY: "1" on the fake, so every CTS call fails with CTWS809, then run
# docker compose up -d lis-fake-service in lis-dev. Run with --grep "@ctssendfailure", then set it back to "0".
# The receipt isn't in the API response, so check in the second API's Postgres that cts_receipt_number and
# cts_sent_at are empty for this bundle.
@skip @api @cattleapi @ctssendfailure @LREG-925 @timeout:120000
Feature: Cattle API - CTS send failure

    Scenario: A bundle that can't be sent to CTS is marked as errored
        When I send a registration bundle to the Cattle API with:
            """
            {
              "clientReference": "{clientReference}",
              "holding": { "cph": "22/001/0001" },
              "submittedBy": "lis-journey-tests",
              "animals": [
                {
                  "earTag": "UK100000000004",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Female",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                }
              ]
            }
            """
        Then the Cattle API accepts the registration bundle
        When the Cattle API has finished processing the bundle for holding "22/001/0001"
        Then the bundle status is "error"
