# CTS status flow (LREG-925 / LREG-926): a bundle sent to POST /v1/registrations goes on the
# lis_cattle_registration_bundle queue, is sent to CTS as a Birth request, and a poller records the outcome.
#
# A one-off check, skipped by default (@skip). The queue doesn't exist on CDP yet, and lis-dev's own Cattle API
# isn't set up for it, so it runs against a second Cattle API started from the API repo, beside lis-dev:
# 1. In lis-dev/api/cattle/compose.override.yml (don't commit), under lis_cattle > environment:
#    - change the three host.docker.internal:3000 addresses to :3010 (lis-dev's fake service; 3000 is fake-idp)
#    - add CtsPollingJob__CronSchedule: "0/5 * * * * ?" (default is every 30s)
#      and CtsPollingJob__UnknownReceiptMaxAgeHours: "0"
# 2. In lis-dev/.tools/compose/dev-tools.yml, under lis-fake-service > environment, add
#    CTS_WS_SERVICE_UNAVAILABLE_PROBABILITY: "0" (otherwise about 1 in 20 CTS calls fail with CTWS809),
#    then run docker compose up -d lis-fake-service in lis-dev.
# 3. In lis-dev/api/cattle run docker compose -f compose.override.yml up --build -d (the API is on port 3001).
# 4. Set LIS_CATTLE_API_BASE_URL=http://localhost:3001 in .env.dev, remove @skip and run:
#    $env:ENVIRONMENT="dev"; npx bddgen; npx playwright test --grep "@ctsstatus"
# 5. Put @skip back, set LIS_CATTLE_API_BASE_URL back to http://localhost:8091, and in lis-dev/api/cattle run
#    docker compose -f compose.override.yml down -v, which also deletes that API's database.
# The second API has its own Postgres, so lis-dev's data (35 cattle on 22/001/0001) isn't touched.
#
# The fake's unused ear tags (UK100000000001-0012) and dam UK200000000007 are fixed files, so they work on every run.
# UK123456789012 is a valid ear tag that was never issued, so CTS rejects it with CTWS111.
# Each run finds its own bundle by a unique client reference, as there is no API to delete one.
#
# LREG-926: these scenarios check each animal's status and error codes and the bundle's final status.
# Checked by hand on the run of 24 Nov 2026, as the API doesn't return them:
# - one CTS status call per bundle, not per animal (counted in the fake's logs)
# - a bundle can take several polls (the first poll logged "not ready yet", the second completed it)
# - completed_at and updated_at are set, and exactly one error row is stored per CTS error (Postgres)
# - a completed bundle isn't polled again (the API's logs)
#
# LREG-926 not tested yet, so we don't forget:
# - CTS unavailable while polling: the bundle is left unchanged, the failure is logged and the batch carries on.
#   The fake's outage setting also fails the first send, so the bundle never gets a receipt to poll with.
#   Asked the dev for a fake setting that only fails the status calls.
# - Animals missing from a response keep their status and a later poll updates them. The fake returned every
#   animal in one response. Asked the dev whether it can split them.
# - Bundles without a receipt are left alone, each bundle is polled by only one of several API instances, and
#   polling the same response twice changes nothing. Can't be set up through the API. Left to the dev's tests.
@skip @api @cattleapi @ctsstatus @LREG-925 @LREG-926 @timeout:120000
Feature: Cattle API - CTS status

    Scenario: A bundle where CTS accepts every animal is complete
        When I send a registration bundle to the Cattle API with:
            """
            {
              "clientReference": "{clientReference}",
              "holding": { "cph": "22/001/0001" },
              "submittedBy": "lis-journey-tests",
              "animals": [
                {
                  "earTag": "UK100000000001",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Female",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                },
                {
                  "earTag": "UK100000000002",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Male",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                }
              ]
            }
            """
        Then the Cattle API accepts the registration bundle
        When the Cattle API has finished processing the bundle for holding "22/001/0001"
        Then the bundle status is "complete"
        And animal "UK100000000001" in the bundle has status "complete" with no errors
        And animal "UK100000000002" in the bundle has status "complete" with no errors

    Scenario: A bundle where CTS rejects one animal is complete with errors
        When I send a registration bundle to the Cattle API with:
            """
            {
              "clientReference": "{clientReference}",
              "holding": { "cph": "22/001/0001" },
              "submittedBy": "lis-journey-tests",
              "animals": [
                {
                  "earTag": "UK100000000003",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Female",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                },
                {
                  "earTag": "UK123456789012",
                  "dateOfBirth": "2026-11-01",
                  "sex": "Male",
                  "breed": "HI",
                  "dam": { "type": "genetic", "geneticDamEarTag": "UK200000000007", "surrogateDamEarTag": "" }
                }
              ]
            }
            """
        Then the Cattle API accepts the registration bundle
        When the Cattle API has finished processing the bundle for holding "22/001/0001"
        Then the bundle status is "complete_with_errors"
        And animal "UK100000000003" in the bundle has status "complete" with no errors
        And animal "UK123456789012" in the bundle has status "error" with error code "CTWS111"
