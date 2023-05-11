//
//  Waiter.swift
//  Lokomond-Code-ChallangeTests
//
//  Created by Kiarash Vosough on 5/11/23.
//

import XCTest

extension XCTWaiter {
    func wait(for timeout: Double) {
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: timeout + 0.2)
    }
}
