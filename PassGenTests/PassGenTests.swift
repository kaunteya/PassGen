//
//  PassGenTests.swift
//  PassGenTests
//
//  Created by Kaunteya Suryawanshi on 23/04/20.
//  Copyright © 2020 Kaunteya Suryawanshi. All rights reserved.
//

import XCTest
@testable import PassGen

class PassGenTests: XCTestCase {

    let generator = PasswordGenerator()

    func testExample() throws {
        let val = generator(upperCase: true, lowerCase: false, numbers: false, symbols: false, length: 10)
        XCTAssertEqual(val.count, 10)
        XCTAssert(val.allSatisfy { $0.isUppercase })
    }

}
