//
//  PersistRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

public protocol PersistRatesServiceProtocol {
    func areRateAvailable() async throws -> Bool
    func updateRates(rates: [FullRateInformationEntity]) async throws
    func persistRates(rates: [RateEntity]) async throws
}
