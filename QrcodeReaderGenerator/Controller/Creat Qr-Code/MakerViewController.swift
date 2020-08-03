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
      qrcodeSheeet()
    }
  }

  /// This method is an actionSheet asking user if he wants logo inside own QR-Code
  private func qrcodeSheeet() {
    let msg = "Souohaitez-vous ajouter un logo au QR-Code?"
    let sheet = UIAlertController(title: nil, message: msg, preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (_) in
      guard let qrcode = self.creatQrcodeLogo() else {return}
      self.performSegue(withIdentifier: "segueFromMVCtoMRVC", sender: [qrcode])
    }))
    sheet.addAction(UIAlertAction(title: "Non", style: .default, handler: { (_) in
      guard let qrcode = self.creatQrcode() else {return}
      self.performSegue(withIdentifier: "segueFromMVCtoMRVC", sender: [qrcode])
    }))
    sheet.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: { (_) in
      self.dismiss(animated: true)
    }))
    present(sheet, animated: true)
  }

  /// This method crreat QR-Code with logo and send to next VC
  private func creatQrcodeLogo() -> UIImage? {
    guard let message = setText(),
          let qrc = message.qrCodeLogo else { return nil }
    return qrc
  }

  /// This method creat QR-Code and send to next VC
  private func creatQrcode() -> UIImage? {
    guard let message = setText(),
          let qrc = message.qrCode else { return nil }
    let qrcode = UIImage(ciImage: qrc)
    return qrcode
  }

  /// This methode return text to includ in QR-Code
  private func setText() -> String? {
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
    return message
  }
}
