//
//  Fonts.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import SwiftUI
import Foundation

extension CTFont {
    fileprivate static func font(_ type: Fonts.FontType, size: CGFloat) -> CTFont {
        CTFont(type.cFString, size: size)
    }
}

internal struct Fonts {

    static private let headingsSize = CGFloat(48)
    static private let titleSize = CGFloat(18)
    static private let bodySize = CGFloat(20)
    static private let overlineSize = CGFloat(12)

    enum FontType: String {
        case bold
        case medium
        case regular

        fileprivate var cFString: CFString {
            ("Satoshi-" + self.rawValue.capitalized) as CFString
        }
    }
    
    struct Headings {
        static let bold = CTFont.font(.bold, size: headingsSize)
    }

    struct Title {
        static let bold = CTFont.font(.bold, size: headingsSize)
    }

    struct SmallSubtitle {
        static let bold = CTFont.font(.regular, size: overlineSize)
    }

    struct Body {
        static let medium = CTFont.font(.medium, size: headingsSize)
    }
}
