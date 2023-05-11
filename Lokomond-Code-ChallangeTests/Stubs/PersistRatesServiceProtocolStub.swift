//
//  PersistRatesServiceProtocolStub.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Foundation
import Lokomond_Code_Challange

struct PersistRatesServiceProtocolStub: Mock {

    enum Action: Equatable {
        case updateRates([FullRateInformationEntity])
        case persistRates([RateEntity])
        case areRateAvailable
    }

    var actions: MockActions<Action>
    private let areRateAvailable: Bool

    init(areRateAvailable: Bool, actions: MockActions<Action>) {
        self.areRateAvailable = areRateAvailable
        self.actions = actions
    }
}

extension PersistRatesServiceProtocolStub: PersistRatesServiceProtocol {

    func areRateAvailable() async throws -> Bool {
        actions.register(.areRateAvailable)
        return areRateAvailable
    }
    
    func updateRates(rates: [FullRateInformationEntity]) async throws {
        actions.register(.updateRates(rates))
    }
    
    func persistRates(rates: [RateEntity]) async throws {
        actions.register(.persistRates(rates))
    }
}
