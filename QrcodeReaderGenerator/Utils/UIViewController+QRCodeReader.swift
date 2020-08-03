//
//  UIViewController+QRCodeReader.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 03/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import AVFoundation
import UIKit

// MARK: - This extension creat a capture session to scan Qr-Code
extension UIViewController: AVCaptureMetadataOutputObjectsDelegate {

  // MARK: - Methods
  /// This method set capture session
  func setupCaptureSession(session: AVCaptureSession) {
    var previewLayer: AVCaptureVideoPreviewLayer!
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
    let videoInput: AVCaptureDeviceInput
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    if session.canAddInput(videoInput) {
      session.addInput(videoInput)
    } else {
      failed(session: session)
      return
    }
    let metadataOutput = AVCaptureMetadataOutput()
    if session.canAddOutput(metadataOutput) {
      session.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      failed(session: session)
      return
    }
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    session.startRunning()
  }

  /// This method display alert if capture failed
  private func failed(session: AVCaptureSession) {
    let alert = UIAlertController(title: nil,
                                  message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
    session.stopRunning()
  }
}
