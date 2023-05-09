//
//  NetworkServices.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import Foundation

public final class NetworkServices {
    internal static let shared = NetworkServices()

    internal let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
    }
}
