//
//  RateEntity.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

public struct Rate {
    public let symbol: String
    public let price: Double

    public init(symbol: String, price: Double) {
        self.symbol = symbol
        self.price = price
    }
}

// MARK: - Hashable
extension Rate: Hashable {}

// MARK: - Codable
extension Rate: Codable {}

// MARK: - Identifiable
extension Rate: Identifiable {
    public var id: Int {
        hashValue
    }
}
