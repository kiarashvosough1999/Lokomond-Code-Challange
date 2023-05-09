//
//  BamaProgressView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public struct BamaProgressView: View {
    
    public var body: some View {
        ProgressView()
            .scaleEffect(2, anchor: .center)
            .progressViewStyle(.circular)
            .tint(.green)
    }
}

#if DEBUG
struct BamaProgressView_Previews: PreviewProvider {
    static var previews: some View {
        BamaProgressView()
    }
}
#endif
