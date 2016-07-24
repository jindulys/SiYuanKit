//
//  GCDQueueTests.swift
//  SiYuanKit
//
//  Created by yansong li on 2016-07-24.
//
//

import XCTest
import SiYuan

class GCDQueueTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testComparison() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      XCTAssertTrue(GCDQueue.serial("test", .default) > GCDQueue.background)
      XCTAssertTrue(GCDQueue.serial("test", .default) > GCDQueue.initiated)
      XCTAssertTrue(GCDQueue.serial("test", .default) ==
          GCDQueue.serial("test2", .background))
    }
}
