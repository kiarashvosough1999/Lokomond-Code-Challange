//
//  JSONLoader.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import XCTest

public enum JSONLoaderError: Error {
    case jsonNotFound
    case dataConversionFailed
}

public protocol JSONLoader: AnyObject {
    
}

extension JSONLoader {

    func loadJSON<D>(name: String, as modelType: D.Type) throws -> D where D: Decodable {
        guard
            let pathURL = Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")
        else {
            throw JSONLoaderError.jsonNotFound
        }

        guard let data = try? Data(contentsOf: pathURL) else {
            throw JSONLoaderError.dataConversionFailed
        }

        return try JSONDecoder().decode(D.self, from: data)
    }
}

extension XCTestCase: JSONLoader {}
