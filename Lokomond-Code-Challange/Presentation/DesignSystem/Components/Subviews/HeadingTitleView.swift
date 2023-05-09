//
//  HeadingTitleView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public struct HeadingTitleView: View {

    private enum Constants {
        static var lineLimit: Int { 1 }
        static var leadingPadding: CGFloat { 24 }
    }
    private let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        Text(title)
            .appFont(Fonts.Headings.bold)
            .lineLimit(Constants.lineLimit)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(.primary_black))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Constants.leadingPadding)
    }
}

#if DEBUG
struct HeadingTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingTitleView(title: "Test")
    }
}
#endif
