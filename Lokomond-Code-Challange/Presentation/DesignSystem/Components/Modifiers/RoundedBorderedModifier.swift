//
//  RoundedBorderedModifier.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

extension View {

    func roundBordered(corderColor: Color = Color(.primary_white)) -> some View {
        self.modifier(RoundedBorderedModifier(corderColor: corderColor))
    }
}

private struct RoundedBorderedModifier: ViewModifier {

    private let corderColor: Color

    init(corderColor: Color) {
        self.corderColor = corderColor
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    Color.gray.opacity(0.05)
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 1)
                        .foregroundColor(corderColor)
                }
            }
    }
}

#if DEBUG
struct RoundedBorderedModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .padding()
            .roundRectangle()
    }
}
#endif
