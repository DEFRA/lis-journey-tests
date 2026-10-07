export async function fetchDefraUserCredentials(
  userRole: string,
  applicationType: 'frontoffice' | 'backoffice'
) {
  userRole = userRole.toUpperCase()
  const emailKey = `LIS_${applicationType.toUpperCase()}_USER_${userRole}_EMAIL`
  const passwordKey = `LIS_${applicationType.toUpperCase()}_USER_${userRole}_PASSWORD`
  if (!Object.keys(process.env).includes(emailKey)) {
    throw new SyntaxError(
      `${emailKey} has not been set. Set this environment variable`
    )
  }
  if (!Object.keys(process.env).includes(passwordKey)) {
    throw new SyntaxError(
      `${passwordKey} has not been set. Set this environment variable`
    )
  }

  return {
    email: process.env[emailKey],
    password: process.env[passwordKey]
  }
}
