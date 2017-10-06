//
//  File.swift
//  SiYuanKit
//
//  Created by yansong li on 2017-10-06.
//

#if os(iOS)
import UIKit

/// A scroll view that can handle keyboard event.
/// TODO(simonli): Take original content insets into account.
class EasyScrollView: UIScrollView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(adjustForKeyboard),
                                   name: Notification.Name.UIKeyboardWillHide,
                                   object: nil)
    notificationCenter.addObserver(self,
                                   selector: #selector(adjustForKeyboard),
                                   name: Notification.Name.UIKeyboardWillShow,
                                   object: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)
  }

  func adjustForKeyboard(notification: Notification) {
    guard let userInfo = notification.userInfo else {
      return
    }
    let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let keyboardViewEndFrame = self.convert(keyboardScreenEndFrame, from: self.window)

    if notification.name == Notification.Name.UIKeyboardDidHide {
      self.contentInset = .zero
    } else {
      self.contentInset = UIEdgeInsets(top: 0,
                                       left: 0,
                                       bottom: keyboardViewEndFrame.height,
                                       right: 0)
    }
    self.scrollIndicatorInsets = self.contentInset
  }
}
#endif


