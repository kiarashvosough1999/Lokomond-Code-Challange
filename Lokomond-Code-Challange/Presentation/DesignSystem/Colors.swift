//
//  Colors.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

internal enum Colors: String {

    case primary_red
    case primary_green
    case primary_white
    case primary_black
    case primary_gray

}

extension SwiftUI.Color {

    internal init(_ color: Colors) {
        self.init(color.rawValue)
    }
}
