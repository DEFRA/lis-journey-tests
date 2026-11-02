// Replaces "today", "yesterday", "tomorrow" or "<n> days ago" (e.g. "28 days ago") with that date; any other value is returned unchanged
export function resolveInputDate(value: string) {
  const date = keywordToDate(value)
  if (!date) return value
  return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`
}

function keywordToDate(value: string) {
  if (value === 'today') return new Date()

  if (value === 'yesterday') {
    const date = new Date()
    date.setDate(date.getDate() - 1)
    return date
  }

  if (value === 'tomorrow') {
    const date = new Date()
    date.setDate(date.getDate() + 1)
    return date
  }

  const daysAgo = /^(\d+) days ago$/.exec(value)
  if (!daysAgo) return undefined

  const date = new Date()
  date.setDate(date.getDate() - Number(daysAgo[1]))
  return date
}

// Replaces the word "today" with today's date as shown on summary pages, e.g. "Moved today" -> "Moved 30 October 2026"
// Use day '2-digit' for pages that show a leading zero, e.g. "01 January 2026"
export function resolveDisplayDate(
  value: string,
  day: 'numeric' | '2-digit' = 'numeric'
) {
  const today = new Date().toLocaleDateString('en-GB', {
    day,
    month: 'long',
    year: 'numeric'
  })
  return value.replace(/\btoday\b/, today)
}
