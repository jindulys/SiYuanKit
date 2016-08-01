//
//  TableViewManager.swift
//  SiYuanKit
//
//  Created by yansong li on 2016-07-31.
//
//

import Foundation

/// Manager to handle TableView related events.
public class TableViewManager: NSObject {
  
  /// The Identifiers registered to the `tableView`.
  public var registeredCellIdentifiers: [String] = []
  
  /**
    tableView object managed by this Manager.
   */
  public var tableView: UITableView? {
    willSet {
      registeredCellIdentifiers = []
    }
    
    didSet {
      tableView?.delegate = self
      tableView?.dataSource = self
      refreshTableView()
    }
  }
  
  /// An array of Row data.
  public var rows: [Row] = [] {
    didSet {
      refreshTableView()
    }
  }
  
  /// Reload tableView and register cell.
  private func refreshTableView() {
    // Execute on main thread.
    let rows =
      self.rows.filter { !self.registeredCellIdentifiers.contains($0.cellIdentifier) }
    rows.forEach { (row) in
      if self.registeredCellIdentifiers.contains(row.cellIdentifier) {
        return
      }
      self.registeredCellIdentifiers.append(row.cellIdentifier)
      self.tableView?.register(row.cellType, forCellReuseIdentifier: row.cellIdentifier)
    }
    self.tableView?.reloadData()
  }
}

extension TableViewManager: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int {
    return rows.count
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView,
             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: row.cellIdentifier,
                                             for: indexPath)
    if let staticCell = cell as? StaticCellType {
      staticCell.configure(row: row)
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

extension TableViewManager: UITableViewDelegate {
  public func tableView(_ tableView: UITableView,
           didSelectRowAt indexPath: IndexPath) {
    let row = rows[indexPath.row]
    row.action?()
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
