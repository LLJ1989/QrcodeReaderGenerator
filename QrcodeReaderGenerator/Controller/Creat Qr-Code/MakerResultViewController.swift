//
//  MakerResultViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

class MakerResultViewController: UIViewController {

  // MARK: - Properties
  var image: [UIImage] = []

  // MARK: - Outlets
  @IBOutlet weak var qrcodeIV: UIImageView!
  @IBOutlet weak var dismissBTN: CustomUIButton!
  @IBOutlet weak var actionBTN: UIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    qrcodeIV.image = image.first
    dismissBTN.setBackBTN()
  }

  // MARK: - Action
  @IBAction func didTapDismissBTN(_ sender: CustomUIButton) {
    performSegue(withIdentifier: "unwindFromMRVCtoHVC", sender: self)
  }
}

// MARK: - This extension manage // SHARING \\
extension MakerResultViewController {

  // MARK: - Action
  @IBAction func didTapActionBTN(_ sender: UIButton) {
    askUser()
  }

  // MARK: - Methods
  /// This methood ask user
  private func askUser() {
    let sheet = UIAlertController(title: nil,
                                  message: "Que souhaitez-vous faire ?",
                                  preferredStyle: .actionSheet)
    sheet.addAction(UIAlertAction(title: "Annuler", style: .default, handler: nil))
    sheet.addAction(UIAlertAction(title: "Partager l'image", style: .default, handler: { (_) in
      self.shareImage()
    }))
    present(sheet, animated: true)
  }

  /// This method share image
  private func shareImage() {
    guard let image = qrcodeIV.image else { return }
    let imageToShare = [image]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    activityViewController.excludedActivityTypes = [.postToVimeo]
    self.present(activityViewController, animated: true)
  }
}
