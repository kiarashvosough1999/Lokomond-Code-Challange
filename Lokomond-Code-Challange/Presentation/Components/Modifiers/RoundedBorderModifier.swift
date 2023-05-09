//
//  RoundedBorderModifier.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

extension View {

    func roundBordered(corderColor: Color = .blue) -> some View {
        self.modifier(RoundedBorderModifier(corderColor: corderColor))
    }
}

private struct RoundedBorderModifier: ViewModifier {

    private let corderColor: Color

    init(corderColor: Color) {
        self.corderColor = corderColor
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    Color.gray.opacity(0.05)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(corderColor)
                }
            }
    }
}

#if DEBUG
struct RoundedBorderModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .padding()
            .modifier(RoundedBorderModifier(corderColor: .blue))
    }
}
#endif
