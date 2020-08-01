//
//  UIViewController+KeyBoard.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

// MARK: - This extension hides keyboard when tappedAround
extension UIViewController {

  // MARK: - This extension (two following methodes) hides keyboard when tappedAround
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.disKeybd))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  @objc func disKeybd() {
    view.endEditing(true)
  }
}
