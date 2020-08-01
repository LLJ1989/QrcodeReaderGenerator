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

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    qrcodeIV.image = image.first
    dismissBTN.setBackBTN()
  }

  // MARK: - Action
  @IBAction func didTapDismissBTN(_ sender: CustomUIButton) {
    dismiss(animated: true)
  }
}
