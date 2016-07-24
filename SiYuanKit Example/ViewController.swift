//
//  ViewController.swift
//  SiYuanKit Example
//
//  Created by yansong li on 2016-07-17.
//
//

import UIKit
import SiYuan

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    testPromise()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func testYSOperation() -> Void {
    let block1 = BlockOperation {
      let dispatchTime = DispatchTime.now() + 3.0
      DispatchQueue.main.after(when: dispatchTime) {
        print("Print something out")
      }
    }
    let queue = YSOperationQueue()
    queue.addOperation(block1)
  }
  
  func testPromise() {
    let myFirstPromise = Promise<Int> {resolve, failure in
      GCDQueue.utility.after(when: 3.0, execute: {
        print("Finished First Promise")
        resolve(20)
      })
    }
    
    let mySecondPromise = Promise<String> { resolve, failure in
      GCDQueue.utility.after(when: 3.0, execute: {
        print("Finished Resolve String")
        resolve("Fake string")
      })
    }
    
    let myThirdPromise = myFirstPromise.registerThen(p: mySecondPromise)
    
    myThirdPromise.then { (str) -> Float in
      print("Finished Final Returning")
      return 66.6
    }
  }
}

