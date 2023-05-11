//
//  StatusView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public struct StatusView: View {

    private let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .appFont(Fonts.SmallSubtitle.regular)
            .foregroundColor(Color(.primary_gray))
    }
}

#if DEBUG
struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(text: Date().description)
    }
}
#endif
