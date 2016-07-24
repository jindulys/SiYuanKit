//
//  PromiseTests.swift
//  SiYuanKit
//
//  Created by yansong li on 2016-07-24.
//
//

import XCTest
import SiYuan

class PromiseTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testChainablePromise() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let e = expectation(withDescription: "Fulfilled")
      let myFirstPromise = Promise<Int> {resolve, failure in
        GCDQueue.utility.after(when: 3.0, execute: {
          resolve(20)
        })
      }
      
      let mySecondPromise = Promise<String> { resolve, failure in
        GCDQueue.utility.after(when: 3.0, execute: {
          resolve("Fake string")
        })
      }
      
      let myThirdPromise = myFirstPromise.registerThen(p: mySecondPromise)
      
      myThirdPromise.then { (str) -> Float in
        e.fulfill()
        return 66.6
      }
      waitForExpectations(withTimeout: 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
