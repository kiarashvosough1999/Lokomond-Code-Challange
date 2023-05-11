//
//  RateEntity.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

public struct RateEntity {
    public let symbol: String
    public let price: Double

    public init(symbol: String, price: Double) {
        self.symbol = symbol
        self.price = price
    }
}

// MARK: - Hashable
extension RateEntity: Hashable {}

// MARK: - Codable
extension RateEntity: Codable {}

// MARK: - Identifiable
extension RateEntity: Identifiable {
    public var id: Int {
        hashValue
    }
}
