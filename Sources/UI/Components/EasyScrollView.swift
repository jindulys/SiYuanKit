//
//  File.swift
//  SiYuanKit
//
//  Created by yansong li on 2017-10-06.
//

#if os(iOS)
import UIKit

public protocol EasyScrollViewTextFieldDelegate: UITextFieldDelegate {
}

/// A scroll view that can handle keyboard event.
/// TODO(simonli): Take original content insets into account.
open class EasyScrollView: UIScrollView {

  public let contentView: UIView

  /// Those two constraints determine scroll view at least have screen size content.
  fileprivate var contentMinimumHeightConstraint: NSLayoutConstraint?
  fileprivate var contentMinimumWidthConstraint: NSLayoutConstraint?

  /// This field is used for correct content offset calculation when keyboard shows up.
  /// This one will always at the center of screen.
  fileprivate var activeTextField: UITextField?

  /// Keyboard height.
  fileprivate var keyboardHeight: CGFloat = 0.0

  /// A delegate which is used for user to notice textField related event.
  public var easyScrollViewDelegate: EasyScrollViewTextFieldDelegate?

  public override init(frame: CGRect) {
    contentView = UIView()
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
    self.addAutoLayoutSubView(contentView)
    self.buildConstraints()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)
  }

  open override var frame: CGRect {
    didSet {
      contentMinimumHeightConstraint?.constant = frame.height
      contentMinimumWidthConstraint?.constant = frame.width
    }
  }

  open override var bounds: CGRect {
    didSet {
      contentMinimumHeightConstraint?.constant = frame.height
      contentMinimumWidthConstraint?.constant = frame.width
    }
  }

  /// User of this view should use this method to add subview.
  public func addAutoLayoutSubViewToContentView(_ view: UIView) {
    contentView.addAutoLayoutSubView(view)
    handleTextFieldWith(view: view)
  }
}

extension EasyScrollView {
  fileprivate func buildConstraints() {
    contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    contentMinimumWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: 0)
    contentMinimumWidthConstraint?.isActive = true
    contentMinimumWidthConstraint?.priority = .defaultLow
    contentMinimumHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
    contentMinimumHeightConstraint?.isActive = true
    contentMinimumHeightConstraint?.priority = .defaultLow
  }

  fileprivate func handleTextFieldWith(view: UIView) {
    if let textField = view as? UITextField {
      textField.delegate = self
      return
    }
    for view in view.subviews {
      handleTextFieldWith(view: view)
    }
  }

  @objc func adjustForKeyboard(notification: Notification) {
    guard let userInfo = notification.userInfo else {
      return
    }
    let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let keyboardViewEndFrame = self.convert(keyboardScreenEndFrame, from: self.window)

    if notification.name == Notification.Name.UIKeyboardWillHide {
      keyboardHeight = 0.0
    } else {
      keyboardHeight = keyboardViewEndFrame.height
    }
    adjustScrollViewWithTextFieldEvent()
  }

  fileprivate func adjustScrollViewWithTextFieldEvent() {
    var offset: CGPoint = .zero
    if keyboardHeight == 0.0 {
      offset = .zero
      self.contentInset = .zero
    } else {
      if let textField = activeTextField {
        let activeTextFieldFrame = self.contentView.convert(textField.frame, from: textField)
        let offsetY = activeTextFieldFrame.origin.y - (bounds.height - keyboardHeight - activeTextFieldFrame.height) / 2
        offset = CGPoint(x: 0, y: offsetY)
      }
      self.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
    }
    UIView.animate(withDuration: 0.2, animations: {
      self.contentOffset = offset
    })
  }
}

extension EasyScrollView: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    activeTextField = textField
    if let d = self.easyScrollViewDelegate, d.responds(to:#selector(textFieldDidBeginEditing(_:))) {
      d.textFieldDidBeginEditing!(textField)
    }
    adjustScrollViewWithTextFieldEvent()
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    activeTextField = nil
    if let d = self.easyScrollViewDelegate, d.responds(to: #selector(textFieldDidEndEditing(_:))) {
      d.textFieldDidEndEditing!(textField)
    }
  }

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    activeTextField = nil
    keyboardHeight = 0.0
    if let d = self.easyScrollViewDelegate, d.responds(to:#selector(textFieldShouldReturn(_:))) {
      return d.textFieldShouldReturn!(textField)
    } else {
      return true
    }
  }
}
#endif


