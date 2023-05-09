//
//  GateWays.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import Foundation

public enum GateWays: String {
    case base = "https://jsonplaceholder.typicode.com"
}

extension GateWays {
    internal func get() -> URL? {
        return URL(string: rawValue)
    }
}
