//
//  LoadRatesUseCaseTests.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import XCTest
import Lokomond_Code_Challange
import Dependencies

final class LoadRatesUseCaseTests: XCTestCase {

    private var sut: LoadRatesUseCaseProtocol?
    
    override func setUpWithError() throws {
        sut = LoadRatesUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_start_loading_rates_unavailable() async throws {

        let rates = try loadJSON(name: "RateEntityJSON", as: [RateEntity].self)
        
        let dbRates: [RateEntity] = rates
        let remoteRates: [RateEntity] = rates
        let areRateAvailable = false
        
        let fetchRatesRemoteServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            .loadRates
        ])

        let fetchRatesDBServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            
        ])
        
        let persistRatesDBServiceActions = MockActions<PersistRatesServiceProtocolStub.Action>(expected: [
            .areRateAvailable,
            .persistRates(dbRates)
        ])
        
        try await withDependencies { values in
            values.fetchRatesRemoteService = FetchRatesServiceProtocolStub(rates: remoteRates, actions: fetchRatesRemoteServiceActions)
            values.fetchRatesDbService = FetchRatesServiceProtocolStub(rates: dbRates, actions: fetchRatesDBServiceActions)
            values.persistRatesDBService = PersistRatesServiceProtocolStub(areRateAvailable: areRateAvailable, actions: persistRatesDBServiceActions)
        } operation: {
            try await self.sut?.startLoading()
        }

        fetchRatesRemoteServiceActions.verify()
        fetchRatesDBServiceActions.verify()
        persistRatesDBServiceActions.verify()
    }

    func test_start_loading_rates_unavailable_empty_rates() async throws {
        let rates = try loadJSON(name: "RateEntityJSON", as: [RateEntity].self)
        
        let dbRates: [RateEntity] = []
        let remoteRates: [RateEntity] = []
        let areRateAvailable = false
        
        let fetchRatesRemoteServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            .loadRates
        ])

        let fetchRatesDBServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            
        ])
        
        let persistRatesDBServiceActions = MockActions<PersistRatesServiceProtocolStub.Action>(expected: [
            .areRateAvailable,
            .persistRates(dbRates)
        ])
        
        try await withDependencies { values in
            values.fetchRatesRemoteService = FetchRatesServiceProtocolStub(rates: remoteRates, actions: fetchRatesRemoteServiceActions)
            values.fetchRatesDbService = FetchRatesServiceProtocolStub(rates: dbRates, actions: fetchRatesDBServiceActions)
            values.persistRatesDBService = PersistRatesServiceProtocolStub(areRateAvailable: areRateAvailable, actions: persistRatesDBServiceActions)
        } operation: {
            try await self.sut?.startLoading()
        }

        fetchRatesRemoteServiceActions.verify()
        fetchRatesDBServiceActions.verify()
        persistRatesDBServiceActions.verify()
    }

    func test_start_loading_rates_available() async throws {

        let rates = try loadJSON(name: "RateEntityJSON", as: [RateEntity].self)
        var rateInfo: [FullRateInformationEntity] {
            rates.map {
                FullRateInformationEntity(symbol: $0.symbol, price: $0.price)
            }
        }
        
        let dbRates: [RateEntity] = rates
        let remoteRates: [RateEntity] = rates
        let areRateAvailable = true
        
        let fetchRatesRemoteServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            .loadRates
        ])

        let fetchRatesDBServiceActions = MockActions<FetchRatesServiceProtocolStub.Action>(expected: [
            .loadRates
        ])
        
        let persistRatesDBServiceActions = MockActions<PersistRatesServiceProtocolStub.Action>(expected: [
            .areRateAvailable,
            .updateRates(rateInfo)
        ])
        
        try await withDependencies { values in
            values.fetchRatesRemoteService = FetchRatesServiceProtocolStub(rates: remoteRates, actions: fetchRatesRemoteServiceActions)
            values.fetchRatesDbService = FetchRatesServiceProtocolStub(rates: dbRates, actions: fetchRatesDBServiceActions)
            values.persistRatesDBService = PersistRatesServiceProtocolStub(areRateAvailable: areRateAvailable, actions: persistRatesDBServiceActions)
        } operation: {
            try await self.sut?.startLoading()
        }

        XCTWaiter().wait(for: 2)
        
        fetchRatesRemoteServiceActions.verify()
        fetchRatesDBServiceActions.verify()
        persistRatesDBServiceActions.verify()
    }
}
