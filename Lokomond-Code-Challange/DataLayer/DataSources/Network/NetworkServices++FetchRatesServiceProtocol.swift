//
//  NetworkServices++FetchRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/10/23.
//

import Foundation
import Dependencies
import Combine

extension NetworkServices: FetchRatesServiceProtocol {

    public func loadRates() async throws -> [RateEntity] {
        let response = try await session.data(for: PostsRequest())

        guard response.statusCode == .OK else { throw NetworkError.requestFailed }

        return try response.decode(to: RateResponse.self).rates
    }
}

// MARK: - Request

fileprivate struct PostsRequest {}

extension PostsRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "code-challenge/index.php" }
}

// MARK: Response

fileprivate struct RateResponse: Decodable {
    let rates: [RateEntity]
}

// MARK: - Dependency

extension DependencyValues {

    public var fetchRatesRemoteService: FetchRatesServiceProtocol {
        get { self[FetchRatesServiceProtocolKey.self] }
        set { self[FetchRatesServiceProtocolKey.self] = newValue }
    }

    private enum FetchRatesServiceProtocolKey: DependencyKey {
        static let liveValue: FetchRatesServiceProtocol = NetworkServices.shared
        static var testValue: FetchRatesServiceProtocol  = NetworkServices.shared
    }
}
