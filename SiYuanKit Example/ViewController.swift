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
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 40
    let row1:Row = Row(title: "Row1djakljdflkajsdlkfjaiosdjflkasjdfkljaskldjfklajsdflkjalksdjflkjasdlkfjlkasjdfkljasdlkfjlkajsdflkjaklsdjflkjasdlkfjlad", description: "Lala", image: nil, action: {
        print("Out Out")
      }, cellIdentifier: "cell1")
    let row2 = Row(title: "Row2", description: "This is a quite long sentence and i hope that this sentence could be truncated if needed, this means that I could happily go to sleep without any worries", cellType: ItemCell.self, cellIdentifier: "item")
    let testRows = [row1, row2]
    
    let row3 = row2
    let row4 = row2
    
    let sections = Section(title: "Section1", rows: testRows)
    
    let sec2 = Section(title: "Section2", rows: [row3, row4])
    
    tableManager.data = .SingleSection(testRows)
    GCDQueue.main.after(when: 3.0) { 
      self.tableManager.data = .MultiSection([sections, sec2])
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

