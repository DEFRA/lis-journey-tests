// Runs step for each item one after another, waiting for each to finish before starting the next.
// Use it for page actions that must happen in order, e.g. clicks and typing.
// Does the same as `for (const item of items) await step(item)`, which Sonar flags (rule S9382)
export async function runInOrder<T>(
  items: readonly T[],
  step: (item: T, index: number) => Promise<unknown>
) {
  await items.reduce<Promise<unknown>>(
    (previous, item, index) => previous.then(() => step(item, index)),
    Promise.resolve()
  )
}
