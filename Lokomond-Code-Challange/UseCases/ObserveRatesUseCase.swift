//
//  ObserveRatesUseCase.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/11/23.
//

import Combine
import Dependencies

// MARK: - Abstraction

public protocol ObserveRatesUseCaseProtocol {
    func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never>
}

// MARK: - Implementation

public final class ObserveRatesUseCase {
    
    fileprivate static let shared = ObserveRatesUseCase()
    
    @Dependency(\.observeRatesDBService) private var observeRatesDBService

    public init() {}
}

extension ObserveRatesUseCase: ObserveRatesUseCaseProtocol {
    public func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never> {
        observeRatesDBService.observeRates()
    }
}

// MARK: Preview

#if DEBUG
public final class ObserveRatesUseCasePreview {
}

extension ObserveRatesUseCasePreview: ObserveRatesUseCaseProtocol {
    public  func observeRates() -> AnyPublisher<[FullRateInformationEntity], Never> {
        Just([]).eraseToAnyPublisher()
    }
}
#endif

// MARK: - Dependency
extension DependencyValues {
    
    public var observeRatesUseCase: ObserveRatesUseCaseProtocol {
        get { self[ObserveRatesUseCaseKey.self] }
        set { self[ObserveRatesUseCaseKey.self] = newValue }
    }
    
    private enum ObserveRatesUseCaseKey: DependencyKey {
        static let testValue: ObserveRatesUseCaseProtocol = ObserveRatesUseCase.shared
        static let liveValue: ObserveRatesUseCaseProtocol = ObserveRatesUseCase.shared
        static let previewValue: ObserveRatesUseCaseProtocol = ObserveRatesUseCasePreview()
    }
}
