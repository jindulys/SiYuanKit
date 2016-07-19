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
    self.testYSOperation()
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

