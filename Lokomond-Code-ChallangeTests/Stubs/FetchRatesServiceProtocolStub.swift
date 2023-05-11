//
//  FetchRatesServiceProtocolStub.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Lokomond_Code_Challange
import Foundation

internal struct FetchRatesServiceProtocolStub: Mock {

    enum Action: Equatable {
        case loadRates
    }

    var actions: MockActions<Action>
    private let rates: [RateEntity]

    init(rates: [RateEntity], actions: MockActions<Action>) {
        self.rates = rates
        self.actions = actions
    }
}

extension FetchRatesServiceProtocolStub: FetchRatesServiceProtocol {

    func loadRates() async throws -> [RateEntity] {
        actions.register(.loadRates)
        return rates
    }
}
