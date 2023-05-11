//
//  Images.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI

public enum Images: String {
    case AUDCAD
    case EURUSD
    case GBPJPY
    case JPYAED
    case JPYSEK
    case USDCAD
    case USDGBP
    case decrease_icon
    case increase_icon
}

extension Image {

    internal init(imageKey: Images) {
        self.init(imageKey.rawValue)
    }
}
