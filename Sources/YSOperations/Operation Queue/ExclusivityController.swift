//
//  ExclusivityController.swift
//  SiYuanKit
//
//  Created by yansong li on 2016-07-21.
//
//

import Foundation

/**
  `ExclusivityController` is a singleton to keep track of all the in-flight
  `Operation` instances that have declared themselves as requiring mutual exclusivity.
  We use a singleton because mutual exclusivity must be enforced across the entire app,
  regardless of the `OperationQueue` on which an `Operation` was executed.
 */
class ExclusivityController {
  static let sharedExclusivityController = ExclusivityController()
//  private let serialQueue = DispatchQueue.global().async(group: <#T##DispatchGroup?#>, qos: <#T##DispatchQoS#>, flags: <#T##DispatchWorkItemFlags#>, execute: <#T##() -> Void#>)
}
