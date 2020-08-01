//
//  HomeViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var addBtn: CustomUIButton!
  @IBOutlet weak var searchBTN: CustomUIButton!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonsDesign()
  }
  @IBAction func didTapAddBTN(_ sender: Any) {
  }
}

// MARK: - This extension manage // NAVIGATION \\
extension HomeViewController {

  // MARK: - Action
  @IBAction func didTapSearchBTN(_ sender: CustomUIButton) {
    performSegue(withIdentifier: "segueFromHVCtoRVC", sender: self)
  }
}

// MARK: - This extension manage // APPEARANCE \\
extension HomeViewController {

  // MARK: - Methods
  /// This method sets button's designn
  func setButtonsDesign() {
    addBtn.setAddBTN()
    searchBTN.setCheckBTN()
  }
}
