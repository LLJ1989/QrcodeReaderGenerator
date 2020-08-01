//
//  ReaderViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit
import AVFoundation

class ReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

  // MARK: - Properties
  var captureSession: AVCaptureSession!
  var previewLayer: AVCaptureVideoPreviewLayer!

  // MARK: - Outlets
  @IBOutlet weak var dismissBTN: CustomUIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession()
    dismissBTN.setBackBTN()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if captureSession?.isRunning == false {
      captureSession.startRunning()
    }
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if captureSession?.isRunning == true {
      captureSession.stopRunning()
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueFromRVCtoRRVC",
       let vcToShow = segue.destination as? ReaderResultViewController,
       let result = sender as? [String] {
        vcToShow.result = result
    }
  }

  // MARK: - Action
  @IBAction func didTapDismissBTN(_ sender: CustomUIButton) {
    dismiss(animated: true)
  }
}

// MARK: - This eextention manage // CAPTURE QR CODE \\
extension ReaderViewController {

  // MARK: - Methods
  /// This method set capture session
  func setupCaptureSession() {
    //view.backgroundColor = UIColor.black
    captureSession = AVCaptureSession()
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
    let videoInput: AVCaptureDeviceInput
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      failed()
      return
    }
    let metadataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      failed()
      return
    }
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    view.addSubview(dismissBTN)
    captureSession.startRunning()
  }

  /// This method display alert if capture failed
  private func failed() {
    let alert = UIAlertController(title: nil,
                                  message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
    captureSession = nil
  }

  /// This method analyse qr-code
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    captureSession.stopRunning()
    if let metadataObject = metadataObjects.first {
      guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
      guard let stringValue = readableObject.stringValue else { return }
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      found(code: stringValue)
    }
  }

  /// This method manage using data in qr-code
  private func found(code: String) {
    performSegue(withIdentifier: "segueFromRVCtoRRVC", sender: [code])
  }
}
