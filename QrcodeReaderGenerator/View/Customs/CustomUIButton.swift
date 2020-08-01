//
//  CustomUIButton.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit
import FontAwesome_swift

class CustomUIButton: UIButton {

  // MARK: - Methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    setCorner()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setCorner()
  }

  /// This method sets corner radius and background color
  func setCorner() {
    self.backgroundColor = .lightGray
    self.layer.cornerRadius = frame.size.height / 2
    self.clipsToBounds = false
  }

  // MARK: - These following methods manage Big Button Design
  /// This method sets design of check customer's button
  func setCheckBTN() {
    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor.black.cgColor
    self.setTitleColor(.black, for: .normal)
    self.titleLabel?.font = .fontAwesome(ofSize: 48, style: .solid)
    self.setTitle(.fontAwesomeIcon(name: .search), for: .normal)
    self.tintColor = .black
  }

  /// This method sets design of add customer's button
  func setAddBTN() {
    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor.black.cgColor
    self.setTitleColor(.black, for: .normal)
    self.titleLabel?.font = .fontAwesome(ofSize: 48, style: .solid)
    self.setTitle(.fontAwesomeIcon(name: .plus), for: .normal)
    self.tintColor = .black
  }

}
