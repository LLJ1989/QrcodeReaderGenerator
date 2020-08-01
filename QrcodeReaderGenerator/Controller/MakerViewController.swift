//
//  MakerViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController {

  // MARK: - Properties
  let alertController = AlertController()

  // MARK: - Outlets
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var mailTF: UITextField!
  @IBOutlet weak var creatBTN: UIButton!
  @IBOutlet weak var dismissBTN: CustomUIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    dismissBTN.setBackBTN()
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueFromMVCtoMRVC",
       let vcToShow = segue.destination as? MakerResultViewController,
       let result = sender as? [UIImage] {
          vcToShow.image = result
    }
  }

  // MARK: - Action
  @IBAction func didTapDismissBTN(_ sender: CustomUIButton) {
    dismiss(animated: true)
  }
}

// MARK: - This extension manage // CREATING QR-CODE \\
extension MakerViewController {

  // MARK: - Action
  @IBAction func didTapCreatBTN(_ sender: UIButton) {
    checkEmptyField()
  }

  // MARK: - Methods
  /// This methods check empty field
  private func checkEmptyField() {
    if nameTF.text == "" {
      let msg = "Veuillez renseigner votre prénom"
      alertController.simpleMessage(self, msg: msg)
    } else if firstNameTF.text == "" {
      let msg = "Veuillez renseigner votre nom"
      alertController.simpleMessage(self, msg: msg)
    } else if mailTF.text == "" {
      let msg = "Veuillez renseigner votre mail"
      alertController.simpleMessage(self, msg: msg)
    } else {
      let qrcode = creatQrcode()
      performSegue(withIdentifier: "segueFromMVCtoMRVC", sender: [qrcode])
    }
  }

  /// This method creat QR-Code and send to next VC
  private func creatQrcode() -> UIImage? {
    guard let name = nameTF.text,
          let firstName = firstNameTF.text,
          let mail = mailTF.text else {
            return nil
    }
    let message = """
                  name => \(name)
                  first name => \(firstName)
                  mail => \(mail)
                  """
    let data = message.data(using: .ascii)
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      let transform = CGAffineTransform(scaleX: 3, y: 3)
      if let output = filter.outputImage?.transformed(by: transform) {
        return UIImage(ciImage: output)
      }
    }
    return nil
  }
}
