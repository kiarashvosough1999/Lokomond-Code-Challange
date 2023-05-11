//
//  FetchResultController++ObserveRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Combine
import Dependencies
import Foundation

extension PersistenceController: ObserveRatesServiceProtocol {

    private var key: String {
        String(describing: RateCDEntity.self)
    }
    
    public func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never> {
        let request = RateCDEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "symbol", ascending: false)
        ]
        let controller = FetchResultController(request: request, managedObjectContext: viewContext)
        self.fetchControllers[key] = controller
        try? controller.start()
        return controller
            .resultPublisher
            .map { cdRate in
                cdRate.map { rate in
                    FullRateInformationEntity(symbol: rate.symbol!, price: rate.price, onIncrease: rate.onIncrease)
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Dependency

extension DependencyValues {

    public var observeRatesDBService: ObserveRatesServiceProtocol {
        get { self[ObserveRatesServiceProtocolKey.self] }
        set { self[ObserveRatesServiceProtocolKey.self] = newValue }
    }

    private enum ObserveRatesServiceProtocolKey: DependencyKey {
        static let liveValue: ObserveRatesServiceProtocol = PersistenceController.shared
        static var testValue: ObserveRatesServiceProtocol = PersistenceController.shared
    }
}
