//
//  MakerViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var firstNameTF: UITextField!
  @IBOutlet weak var mailTF: UITextField!
  @IBOutlet weak var creatBTN: UIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueFromMVCtoMRVC",
       let vcToShow = segue.destination as? MakerResultViewController,
       let result = sender as? [UIImage] {
          vcToShow.image = result
    }
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

    } else if firstNameTF.text == "" {

    } else if mailTF.text == "" {

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

// MARK: - This extension hides keyboard when tappedAround
extension UIViewController {

  // MARK: - This extension (two following methodes) hides keyboard when tappedAround
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.disKeybd))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  @objc func disKeybd() {
    view.endEditing(true)
  }
}
