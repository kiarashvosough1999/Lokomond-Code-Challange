//
//  FetchRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/10/23.
//

public protocol FetchRatesServiceProtocol {
    func loadRates() async throws -> [RateEntity]
}
