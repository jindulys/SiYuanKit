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
  
  let tableView: UITableView = UITableView()
  let tableManager: TableViewManager = TableViewManager()
  
  override func loadView() {
    self.view = tableView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableManager.tableView = tableView
    let row1:Row = Row(title: "Row1", description: "Lala", image: nil, action: nil, cellIdentifier: "cell1")
    let row2 = Row(title: "Row22", description: "dklskjdlajfisdjflkasdjfias")
    let testRows = [row1, row2]
    tableManager.rows = testRows
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

