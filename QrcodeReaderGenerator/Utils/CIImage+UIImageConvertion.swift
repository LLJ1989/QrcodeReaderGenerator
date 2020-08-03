//
//  CIImage+UIImageConvertion.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 03/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - This extension convert CIImage into UIImage
extension CIImage {
    var image: UIImage {
      .init(ciImage: self)
  }
}
