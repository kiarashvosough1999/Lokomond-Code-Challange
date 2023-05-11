//
//  RatePageView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

internal struct RatePageView: View {
    
    @StateObject private var viewModel = RatePageViewModel()
    
    internal var body: some View {
        VStack(spacing: 16) {
            HeadingTitleView(title: "Rates")
            WithLoadingState(state: viewModel.rates) { rates in
                ForEach(rates) { rate in
                    CurrencyRowView(viewModel: rate)
                }
            }
            .onRetry {
                await viewModel.start()
            }
            Spacer()
            StatusView(text: viewModel.lastUpdate)
        }
        .padding(.top, 26)
        .task {
            await viewModel.start()
        }
    }
}

struct RatePageView_Previews: PreviewProvider {
    static var previews: some View {
        RatePageView()
    }
}
