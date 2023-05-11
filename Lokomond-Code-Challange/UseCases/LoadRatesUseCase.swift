//
//  LoadRatesUseCase.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/10/23.
//

import Foundation
import Combine
import Dependencies

public protocol LoadRatesUseCaseProtocol: AnyObject {
    func startLoading() async throws
    func stopLoading()
}

public final class LoadRatesUseCase {

    fileprivate static let shared = LoadRatesUseCase()

    @Dependency(\.fetchRatesRemoteService) private var fetchRatesService
    @Dependency(\.fetchRatesDbService) private var fetchRatesDbService
    @Dependency(\.persistRatesDBService) private var persistRatesDBService

    private var refreshRate: TimeInterval { 5 }
    private var timer: Timer?
    private var ongoingTask: Bool = false
    private var lastTask: Task<Void, Never>?
}

extension LoadRatesUseCase: LoadRatesUseCaseProtocol {

    public func stopLoading() {
        resetTImer()
        lastTask?.cancel()
        lastTask = nil
    }

    private func resetTImer() {
        timer?.invalidate()
        timer = nil
    }

    public func startLoading() async throws {
        let areRateAvailable = try await persistRatesDBService.areRateAvailable()
        // we should first fetch some data and then update them
        if areRateAvailable == false {
            let rates = try await self.fetchRatesService.loadRates()
            try await self.persistRatesDBService.persistRates(rates: rates)

        }

        await self.scehduleTimer()
    }

    @MainActor
    func scehduleTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: refreshRate,
            target: self,
            selector: #selector(timerInovocation),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: .default)
    }

    @objc
    private func timerInovocation() {
        ongoingTask = true
        lastTask = Task {
            try? await self.refreshData()
            self.ongoingTask = false
        }
    }

    private func refreshData() async throws {
        let oldRates = try await self.fetchRatesDbService.loadRates()

        guard Task.isCancelled == false else { return }

        let newRates = try await self.fetchRatesService.loadRates()

        guard Task.isCancelled == false else { return }

        var toSaveRates: [FullRateInformationEntity] {
            zip(oldRates, newRates)
                .map { old, new in
                    FullRateInformationEntity(
                        symbol: new.symbol,
                        price: new.price,
                        onIncrease: new.price > old.price
                    )
                }
        }
        guard Task.isCancelled == false else { return }
        try await self.persistRatesDBService.updateRates(rates: toSaveRates)
    }
}

// MARK: Preview

#if DEBUG
public final class LoadRatesPreviewUseCase {
}

extension LoadRatesPreviewUseCase: LoadRatesUseCaseProtocol {
    public func startLoading() async throws {}
    public func stopLoading() {}
}
#endif

// MARK: - Dependency
extension DependencyValues {
    
    public var loadRatesUseCase: LoadRatesUseCaseProtocol {
        get { self[LoadRatesUseCaseProtocolKey.self] }
        set { self[LoadRatesUseCaseProtocolKey.self] = newValue }
    }
    
    private enum LoadRatesUseCaseProtocolKey: DependencyKey {
        static let testValue: LoadRatesUseCaseProtocol = LoadRatesUseCase.shared
        static let liveValue: LoadRatesUseCaseProtocol = LoadRatesUseCase.shared
        static let previewValue: LoadRatesUseCaseProtocol = LoadRatesPreviewUseCase()
    }
}
