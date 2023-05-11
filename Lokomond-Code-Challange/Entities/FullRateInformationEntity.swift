//
//  FullRateInformationEntity.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/10/23.
//

import Foundation

public struct FullRateInformationEntity {
    public let symbol: String
    public let price: Double
    public let onIncrease: Bool

    public init(symbol: String, price: Double, onIncrease: Bool = false) {
        self.symbol = symbol
        self.price = price
        self.onIncrease = onIncrease
    }
}

// MARK: - Hashable
extension FullRateInformationEntity: Hashable {}

// MARK: - Codable
extension FullRateInformationEntity: Codable {}

// MARK: - Identifiable
extension FullRateInformationEntity: Identifiable {
    public var id: Int {
        hashValue
    }
}
