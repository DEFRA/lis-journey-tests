import { expect, APIRequestContext } from '@playwright/test'
import { StatusCodes } from 'http-status-codes'

export type ApiRequestOptions = NonNullable<
  Parameters<APIRequestContext['get']>[1]
>

export abstract class BaseClient {
  protected readonly apiContext: APIRequestContext
  protected readonly serviceName?: string

  constructor(apiContext: APIRequestContext, serviceName?: string) {
    this.apiContext = apiContext
    this.serviceName = serviceName
  }

  private prepareRemoteRequest(url: string, options?: ApiRequestOptions) {
    if (
      process.env.apiKey !== undefined &&
      process.env.correlationId !== undefined
    ) {
      const requestOptions: ApiRequestOptions = {
        ...options,
        headers: {
          ...options?.headers,
          'Content-Type': 'application/json'
        }
      }
      const absoluteUrl =
        this.serviceName === 'lis-back-office' &&
        process.env.ENVIRONMENT === 'dev' &&
        process.env.CDP === undefined
          ? `/${this.serviceName}` + url
          : url
      return { requestOptions, absoluteUrl }
    }

    return { requestOptions: options, absoluteUrl: url }
  }

  protected async get<T>(
    url: string,
    statusCode: StatusCodes,
    options?: ApiRequestOptions
  ) {
    const request = this.prepareRemoteRequest(url, options)
    const response = await this.apiContext.get(
      request.absoluteUrl,
      request.requestOptions
    )
    expect(response.status()).toEqual(statusCode)
    return (await response.json()) as T
  }

  protected async post<T>(
    url: string,
    statusCode: StatusCodes,
    options?: ApiRequestOptions
  ) {
    const request = this.prepareRemoteRequest(url, options)
    const response = await this.apiContext.post(
      request.absoluteUrl,
      request.requestOptions
    )
    expect(response.status()).toEqual(statusCode)
    if (statusCode === StatusCodes.NO_CONTENT) {
      return {} as T
    } else {
      return (await response.json()) as T
    }
  }

  protected async postWithResponseReturn(
    url: string,
    options?: ApiRequestOptions
  ) {
    const request = this.prepareRemoteRequest(url, options)
    return await this.apiContext.post(
      request.absoluteUrl,
      request.requestOptions
    )
  }

  protected async put<T>(
    url: string,
    statusCode: StatusCodes,
    options?: ApiRequestOptions
  ) {
    const request = this.prepareRemoteRequest(url, options)
    const response = await this.apiContext.put(
      request.absoluteUrl,
      request.requestOptions
    )
    expect(response.status()).toEqual(statusCode)
    return (await response.json()) as T
  }
}
