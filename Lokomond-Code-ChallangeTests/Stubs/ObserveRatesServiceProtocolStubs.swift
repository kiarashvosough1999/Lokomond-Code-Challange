//
//  ObserveRatesServiceProtocolStubs.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Foundation
import Lokomond_Code_Challange
import Combine

internal struct ObserveRatesServiceProtocolStubs: Mock {

    enum Action: Equatable {
        case observeRates
    }

    var actions: MockActions<Action>
    private let rates: [FullRateInformationEntity]

    internal init(rates: [FullRateInformationEntity], actions: MockActions<Action>) {
        self.rates = rates
        self.actions = actions
    }
}

extension ObserveRatesServiceProtocolStubs: ObserveRatesServiceProtocol {

    func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never> {
        actions.register(.observeRates)
        return Just(rates)
            .eraseToAnyPublisher()
    }
}
