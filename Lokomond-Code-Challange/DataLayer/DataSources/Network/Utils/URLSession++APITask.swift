//
//  URLSession++APITask.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//
import Foundation

extension URLSession {

    internal struct APIResponse {
        internal let data: Data
        internal let httpResponse: HTTPURLResponse

        internal var statusCode: StatusCode {
            StatusCode(rawValue: httpResponse.statusCode) ?? .unknown
        }

        internal func decode<M>(to modelType: M.Type) throws -> M where M: Decodable {
            try JSONDecoder().decode(modelType, from: data)
        }
    }

    internal func data<A>(for api: A) async throws -> APIResponse where A: API {
        let (data, response) = try await self.data(for: try api.asURLRequest())

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.failedHTTPURLResponseConversion
        }

        return APIResponse(data: data, httpResponse: httpResponse)
    }
}
