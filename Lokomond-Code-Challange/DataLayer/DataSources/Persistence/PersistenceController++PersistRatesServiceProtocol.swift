//
//  PersistenceController++PersistRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

import CoreData
import Dependencies

extension PersistenceController: PersistRatesServiceProtocol {

    public func persistRates(rates: [RateEntity]) async throws {
        try await self.viewContext.perform(schedule: .immediate) {
            let _ = rates.map { rate in
                let cdRate = RateCDEntity(context: self.viewContext)
                cdRate.symbol = rate.symbol
                cdRate.price = rate.price
                return cdRate
            }
            try self.viewContext.save()
        }
    }
    
    public func areRateAvailable() async throws -> Bool {
        try await self.viewContext.perform(schedule: .immediate) {
            let request = RateCDEntity.fetchRequest()
            let count = try self.viewContext.count(for: request)
            return count != .zero
        }
    }

    public func updateRates(rates: [FullRateInformationEntity]) async throws {
        try await self.viewContext.perform(schedule: .immediate) {
            try rates.forEach { rate in
                let predicate = NSPredicate(format: "symbol == %@", rate.symbol)
                let request = RateCDEntity.fetchRequest()

                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1

                guard let result = try self.viewContext.fetch(request).first else { return }
                result.onIncrease = rate.onIncrease
                result.price = rate.price
                result.symbol = rate.symbol
            }
            try self.viewContext.save()
        }
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var persistRatesDBService: PersistRatesServiceProtocol {
        get { self[PersistRatesServiceProtocolKey.self] }
        set { self[PersistRatesServiceProtocolKey.self] = newValue }
    }

    private enum PersistRatesServiceProtocolKey: DependencyKey {
        static let liveValue: PersistRatesServiceProtocol = PersistenceController.shared
        static var testValue: PersistRatesServiceProtocol = PersistenceController.shared
    }
}
