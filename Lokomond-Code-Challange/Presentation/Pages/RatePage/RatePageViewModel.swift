//
//  RatePageViewModel.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import Foundation

internal final class RatePageViewModel: ObservableObject {
    @Published var rates: PageLoadState<[CurrencyRowViewModel]> = .loaded([
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
        CurrencyRowViewModel(image: .AUDCAD, currencyName: "HDKKD", number: "93.32", indicatorType: .increase),
    ])
}
