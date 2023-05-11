//
//  ObserveRatesServiceProtocol.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Combine

public protocol ObserveRatesServiceProtocol {
    func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never>
}
