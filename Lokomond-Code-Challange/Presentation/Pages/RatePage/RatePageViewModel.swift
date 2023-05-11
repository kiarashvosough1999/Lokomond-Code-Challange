//
//  RatePageViewModel.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import Foundation
import Dependencies

internal final class RatePageViewModel: ObservableObject {
    @Published var rates: PageLoadState<[CurrencyRowViewModel]> = .loading

    @Dependency(\.loadRatesUseCase) private var loadRatesUseCase
    @Dependency(\.observeRatesUseCase) private var observeRatesUseCase

    internal func start() async {
        observeRatesUseCase
            .observeRates()
            .map { rates in
                rates.compactMap { rate in
                    Mapper().map(from: rate)
                }
            }
            .map { PageLoadState.loaded($0) }
            .replaceEmpty(with: .loading)
            .receive(on: DispatchQueue.main)
            .assign(to: &$rates)
        try? await loadRatesUseCase.startLoading()
    }
}

private struct Mapper {

    func map(from model: FullRateInformationEntity) -> CurrencyRowViewModel? {
        guard let image = mapImages(model.symbol) else { return nil }
        return CurrencyRowViewModel(
            image: image,
            currencyName: insertSlash(on: model.symbol),
            number: formatNumber(price: model.price),
            indicatorType: model.onIncrease ? .increase : .decrease
        )
    }

    private func formatNumber(price: Double) -> String {
        String(format: "%.4f", price)
    }
    
    private func insertSlash(on symbol: String) -> String {
        var newSymbol = symbol
        newSymbol.insert("/", at: symbol.index(symbol.startIndex, offsetBy: 3))
        return newSymbol
    }
    
    private func mapImages(_ symbol: String) -> Images? {
        switch symbol {
        case "AUDCAD": return .AUDCAD
        case "EURUSD": return .EURUSD
        case "GBPJPY": return .GBPJPY
        case "JPYAED": return .JPYAED
        case "JPYSEK": return .JPYSEK
        case "USDCAD": return .USDCAD
        case "USDGBP": return .USDGBP
        default: return nil
        }
    }
}
