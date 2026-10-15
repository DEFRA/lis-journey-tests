const dateFormatMarker = 'formatDateYearMonth:'

export type ExpectedAnimalValue =
  { type: 'date'; value: string } | { type: 'text'; value: string }

export function parseExpectedAnimalValue(
  expectedValue: string
): ExpectedAnimalValue {
  if (!expectedValue.startsWith(dateFormatMarker)) {
    return { type: 'text', value: expectedValue }
  }

  const date = expectedValue.slice(dateFormatMarker.length)
  if (!date) {
    throw new Error(`Invalid date format: ${expectedValue}`)
  }

  return { type: 'date', value: date }
}
