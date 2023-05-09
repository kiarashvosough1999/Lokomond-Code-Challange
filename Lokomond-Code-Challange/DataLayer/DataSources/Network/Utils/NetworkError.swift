//
//  NetworkError.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

public enum NetworkError: Error {
    case failedHTTPURLResponseConversion
    case apiURLException
    case requestFailed
    case emptyToken
}
