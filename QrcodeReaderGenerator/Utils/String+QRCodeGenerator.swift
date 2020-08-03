//
//  String+QRCodeGenerator.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 03/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - This extension creat QR-Code from string
extension String {

  // MARK: - QR-Code from string
  var qrCode: CIImage? {
    guard let data = self.data(using: .ascii) else {return nil}
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      let transform = CGAffineTransform(scaleX: 100, y: 100)
      if let output = filter.outputImage?.transformed(by: transform) {
        return output
      }
   }
    return nil
  }

  // MARK: - QR-Code from string with logo in middle
  var qrCodeLogo: UIImage? {
    if let qrcode = self.qrCode {
      guard let log = UIImage(named: "image.png"),
            let logo = CIImage(image: log),
            let qrLogo = qrcode.combined(with: logo) else {return nil}
      return UIImage(ciImage: qrLogo)
    }
    return nil
  }
}
