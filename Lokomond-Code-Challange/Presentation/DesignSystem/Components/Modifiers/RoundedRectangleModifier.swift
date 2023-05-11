//
//  RoundedRectangleModifier.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

extension View {

    func roundRectangle(corderColor: Color = Color(.primary_white)) -> some View {
        self.modifier(RoundedRectangleModifier(corderColor: corderColor))
    }
}

private struct RoundedRectangleModifier: ViewModifier {

    private let corderColor: Color

    init(corderColor: Color) {
        self.corderColor = corderColor
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(corderColor)
            }
    }
}

#if DEBUG
struct RoundedRectangleModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .padding()
            .roundRectangle()
    }
}
#endif
