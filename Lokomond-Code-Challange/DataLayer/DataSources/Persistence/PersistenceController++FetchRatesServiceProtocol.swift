//
//  PersistenceController++FetchRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

import CoreData
import Dependencies

extension PersistenceController: FetchRatesServiceProtocol {

    func loadRates() async throws -> [RateEntity] {
        try await self.viewContext.perform(schedule: .immediate) {
            let request = RateCDEntity.fetchRequest()
            let objects = try self.viewContext.fetch(request)
            return objects.map { rate in
                RateEntity(symbol: rate.symbol!, price: rate.price)
            }
        }
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var fetchRatesDbService: FetchRatesServiceProtocol {
        get { self[FetchRatesServiceProtocolKey.self] }
        set { self[FetchRatesServiceProtocolKey.self] = newValue }
    }

    private enum FetchRatesServiceProtocolKey: DependencyKey {
        static let liveValue: FetchRatesServiceProtocol = PersistenceController.shared
        static var testValue: FetchRatesServiceProtocol = PersistenceController.shared
    }
}
