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
    // Do any additional setup after loading the view, typically from a nib.
    let myFirstPromise = Promise<Int> { resolve, failure in
//      Time.longRun(duration: 3.0)
//      resolve(20)
      GCDQueue.utility.after(when: 3.0, execute: {
        print("Finished First Promise")
        resolve(20)
      })
    }
    myFirstPromise.name = "Fly"
    let mysecondPromise = myFirstPromise.registerThen { (result) -> String in
      return "String"
    }
    mysecondPromise.name = "SKY"
    let myThirdPromise = mysecondPromise.then { (str) -> Float in
      return 66.6
    }
    myThirdPromise.name = "Right"
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
}

