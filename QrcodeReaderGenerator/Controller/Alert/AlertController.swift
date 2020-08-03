//
//  AlertController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

// MARK: - This class manage all the alerts
class AlertController {

  // MARK: - Methods
  /// This a simple generic alert with message
  func simpleMessage(_ controller: UIViewController, msg: String) {
    let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "D'accord", style: .default, handler: nil))
    controller.present(alert, animated: true)
  }
}
