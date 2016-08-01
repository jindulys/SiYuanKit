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
  
  /// Representation of the style of tableViewData.
  public enum TableViewStyle {
    case SingleSection([Row])
    case MultiSection([Section])
  }
  
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
  
  /// The data for this tableViewManager.
  public var data: TableViewStyle = .SingleSection([]) {
    didSet {
      refreshTableView()
    }
  }
}

// MARK: Helpers
extension TableViewManager {
  /// Reload tableView and register cell.
  private func refreshTableView() {
    var rows: [Row] = []
    
    switch data {
    case .SingleSection(let r):
      rows = r.filter { !self.registeredCellIdentifiers.contains($0.cellIdentifier) }
    case .MultiSection(let s):
      rows = s.flatMap { $0.rows }.filter {
        !self.registeredCellIdentifiers.contains($0.cellIdentifier)
      }
    }
    rows.forEach { (row) in
      if self.registeredCellIdentifiers.contains(row.cellIdentifier) {
        return
      }
      self.registeredCellIdentifiers.append(row.cellIdentifier)
      self.tableView?.register(row.cellType, forCellReuseIdentifier: row.cellIdentifier)
    }
    self.tableView?.reloadData()
  }
  
  /// Return row for specified index.
  private func rowForIndexPath(_ index: IndexPath) -> Row? {
    switch data {
    case .SingleSection(let r):
      if r.count > index.row {
        return r[index.row]
      }
    case .MultiSection(let s):
      if s.count > index.section {
        let selectSection = s[index.section]
        if selectSection.rows.count > index.row {
          return selectSection.rows[index.row]
        }
      }
    }
    return nil
  }
}

extension TableViewManager: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int {
    switch data {
    case .SingleSection(let r):
      return r.count
    case .MultiSection(let s):
      return s[section].rows.count
    }
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    switch data {
    case .SingleSection(_):
      return 1
    case .MultiSection(let s):
      return s.count
    }
  }
  
  public func tableView(_ tableView: UITableView,
             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let row = rowForIndexPath(indexPath) {
      let cell = tableView.dequeueReusableCell(withIdentifier: row.cellIdentifier,
                                                          for: indexPath)
      if let staticCell = cell as? StaticCellType {
        staticCell.configure(row: row)
      }
      return cell
    }
    return UITableViewCell()
  }
  
  public func tableView(_ tableView: UITableView,
    titleForHeaderInSection section: Int) -> String? {
    switch data {
    case .SingleSection(_):
      return nil
    case .MultiSection(let s):
      return s[section].title
    }
  }
  
  public func tableView(_ tableView: UITableView,
   heightForHeaderInSection section: Int) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  public func tableView(_ tableView: UITableView,
   heightForFooterInSection section: Int) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  public func tableView(_ tableView: UITableView,
    titleForFooterInSection section: Int) -> String? {
    return nil
  }
}

extension TableViewManager: UITableViewDelegate {
  public func tableView(_ tableView: UITableView,
           didSelectRowAt indexPath: IndexPath) {
    if let row = self.rowForIndexPath(indexPath) {
      row.action?()
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
