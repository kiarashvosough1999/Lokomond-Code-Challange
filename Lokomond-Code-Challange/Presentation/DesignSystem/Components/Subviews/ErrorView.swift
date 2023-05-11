//
//  ErrorView.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public struct ErrorView: View {

    private let message: String
    private let retry: (() async -> Void)?

    init(message: String, retry: (() async -> Void)? = nil) {
        self.message = message
        self.retry = retry
    }

    public var body: some View {
        VStack {
            Text(message)
                .font(.title3)
                .bold()
                .foregroundColor(.red)
            if retry != nil {
                Button(action: {
                    Task {
                        await retry?()
                    }
                }, label: {
                    Text("Retry")
                        .foregroundColor(.green)
                        .frame(maxWidth: 70)
                })
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .roundBordered(corderColor: .red)
        .frame(alignment: .center)
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "not found") { }
    }
}
#endif
