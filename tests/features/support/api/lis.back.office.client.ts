import { StatusCodes } from 'http-status-codes'
import { ApiRequestOptions, BaseClient } from './base.client'

export class LisBackOfficeClient extends BaseClient {
  async get<T>(
    url: string,
    statusCode: StatusCodes,
    options?: ApiRequestOptions
  ): Promise<T> {
    return await super.get<T>(url, statusCode, options)
  }

  async post<T>(
    url: string,
    statusCode: StatusCodes,
    options?: ApiRequestOptions
  ): Promise<T> {
    return await super.post<T>(url, statusCode, options)
  }
}
