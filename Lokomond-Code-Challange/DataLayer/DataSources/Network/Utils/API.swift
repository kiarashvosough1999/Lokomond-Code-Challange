//
//  API.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import Foundation

public protocol API {
    var method: HTTPMethod { get }
    var gateway: GateWays { get }
    var route: String { get }
    var headerParams: [String: Any] { get }
    var useCache: Bool { get }

    @BodyBuilder
    var body: [String: Any] { get }

    func asURLRequest() throws -> URLRequest
}

extension API {

    public var headerParams: [String: Any] { [:] }
    public var useCache: Bool { false }

    public var body: [String: Any] { [:] }

    public func asURLRequest() throws -> URLRequest {
        guard let gateway = gateway.get() else {
            throw NetworkError.apiURLException
        }
        let url = gateway.appending(path: route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        if method != .get && body.isEmpty == false {
            if let jsonData = try? JSONSerialization.data(withJSONObject: body) {
                urlRequest.httpBody = jsonData
            }
        }
        if useCache { urlRequest.cachePolicy = .returnCacheDataElseLoad }
        
        headerParams.forEach { param in
            urlRequest.setValue("\(param.value)", forHTTPHeaderField: param.key)
        }
        return urlRequest
    }
}

internal struct KeyValue {

    fileprivate let key: String
    fileprivate let value: Any

    internal init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
}

@resultBuilder
internal struct BodyBuilder {
    static func buildBlock(_ components: KeyValue...) -> [String: Any] {
        components.reduce(into: [String: Any]()) { partialResult, keyValue in
            partialResult[keyValue.key] = keyValue.value
        }
    }
}
