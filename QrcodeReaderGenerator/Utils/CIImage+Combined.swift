//
//  CIImage+Combined.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 03/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - This extension combines QR-Code with logo
extension CIImage {

  // MARK: - This methood combines the current image with the given image centered.
  func combined(with image: CIImage) -> CIImage? {
    guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
    let centerTransform = CGAffineTransform(translationX: self.extent.midX - (image.extent.size.width / 10), y: self.extent.midY - (image.extent.size.height / 10))
    combinedFilter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
    combinedFilter.setValue(self, forKey: "inputBackgroundImage")
    return combinedFilter.outputImage!
  }
}
