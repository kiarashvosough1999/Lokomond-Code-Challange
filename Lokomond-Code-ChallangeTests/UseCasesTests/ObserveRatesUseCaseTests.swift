//
//  ObserveRatesUseCaseTests.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import XCTest
import Lokomond_Code_Challange
import Dependencies
import CombineExpectations

final class ObserveRatesUseCaseTests: XCTestCase {

    private var sut: ObserveRatesUseCaseProtocol!

    override func setUpWithError() throws {
        sut = ObserveRatesUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_observe_rates() async throws {
        // Given
        let rates = try loadJSON(name: "FullRateInformationEntityJSON", as: [FullRateInformationEntity].self)
        
        let observerateMockAction = MockActions<ObserveRatesServiceProtocolStubs.Action>(expected: [
            .observeRates
        ])
        let observeRatesDBService = ObserveRatesServiceProtocolStubs(
            rates: rates,
            actions: observerateMockAction
        )

        let receivedRates = try withDependencies { values in
            values.observeRatesDBService = observeRatesDBService
        } operation: {
            let recorder = sut.observeRates().record()
            let elements = try wait(for: recorder.elements, timeout: 5, description: "Elements")
            return elements.flatMap { $0 }
        }

        XCTAssertEqual(receivedRates, rates)
        observerateMockAction.verify()
    }
}
