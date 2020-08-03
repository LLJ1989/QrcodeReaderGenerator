//
//  ReaderViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit
import AVFoundation

class ReaderViewController: UIViewController {

  // MARK: - Properties
  let session = AVCaptureSession()

  // MARK: - Outlets
  @IBOutlet weak var dismissBTN: CustomUIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession(session: session)
    dismissBTN.setBackBTN()
    view.addSubview(dismissBTN)
  }

  /// This method manage passing data to nnext VC
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueFromRVCtoRRVC",
       let vcToShow = segue.destination as? ReaderResultViewController,
       let result = sender as? [String] {
        vcToShow.result = result
    }
  }

  /// This method analyse qr-code
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    self.session.stopRunning()
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

  // MARK: - Action
  /// This action manage dismissing current VC
  @IBAction func didTapDismissBTN(_ sender: CustomUIButton) {
    dismiss(animated: true)
  }
}
