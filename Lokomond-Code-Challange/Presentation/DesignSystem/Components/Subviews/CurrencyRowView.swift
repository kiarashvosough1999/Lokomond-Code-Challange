//
//  CurrencyRowView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public struct CurrencyRowViewModel: Hashable, Identifiable {
    
    public enum IndcatorType: Hashable {
        case increase
        case decrease
    }

    public var id: Int {
        hashValue
    }

    fileprivate let image: Images
    fileprivate let currencyName: String
    fileprivate let number: String
    fileprivate let indicatorType: IndcatorType

    public init(
        image: Images,
        currencyName: String,
        number: String,
        indicatorType: IndcatorType
    ) {
        self.image = image
        self.currencyName = currencyName
        self.number = number
        self.indicatorType = indicatorType
    }
}

public struct CurrencyRowView: View {

    private enum Constants {
        static var currencyImagePadding: CGFloat { 16 }
        static var currencyNamePadding: CGFloat { 8 }
        static var height: CGFloat { 70 }
        static var hPadding: CGFloat { 24 }
        static var indicatorLeadingPadding: CGFloat { 5 }
        static var indicatorTrainlingPadding: CGFloat { 27 }
    }
    
    private let viewModel: CurrencyRowViewModel

    public init(viewModel: CurrencyRowViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack {
            Image(imageKey: viewModel.image)
                .padding([.leading, .top, .bottom], Constants.currencyImagePadding)

            Text(viewModel.currencyName)
                .appFont(Fonts.Title.bold)
                .padding(.leading, Constants.currencyNamePadding)

            Spacer()

            Text(viewModel.number)
                .appFont(Fonts.Body.medium)
                .foregroundColor(
                    viewModel.indicatorType == .increase ? Color(.primary_green) : Color(.primary_red)
                )

            Image(imageKey: viewModel.indicatorType == .increase ? .increase_icon : .decrease_icon)
                .padding(.leading, Constants.indicatorLeadingPadding)
                .padding(.trailing, Constants.indicatorTrainlingPadding)
        }
        .frame(height: Constants.height)
        .roundRectangle()
        .padding(.horizontal, Constants.hPadding)
    }
}

#if DEBUG
struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(
            viewModel: CurrencyRowViewModel(
                image: .EURUSD,
                currencyName: "USD/EUR",
                number: "12.323",
                indicatorType: .increase
            )
        )
    }
}
#endif
