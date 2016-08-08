//
//  RoundedViewViewController.swift
//  SiYuanKit
//
//  Created by yansong li on 2016-08-07.
//
//

import Foundation
import UIKit

class RoundedViewViewController: UIViewController {
  let testView = UIView()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black()
    testView.backgroundColor = UIColor.blue()
    testView.frame = CGRect(x: 20.0, y: 180.0, width: 200.0, height: 60.0)
    testView.layer.cornerRadius = 30.0
    testView.clipsToBounds = true
    let subViewOne = UIView()
    subViewOne.backgroundColor = UIColor.yellow()
    subViewOne.frame = CGRect(x: 5.0, y: 5.0, width: 50.0, height: 50.0)
    testView.addSubview(subViewOne)
    self.view.addSubview(testView)
  }
}
