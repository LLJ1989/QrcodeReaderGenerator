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
}

// MARK: - This extension manage // NAVIGATION \\
extension HomeViewController {

  // MARK: - Action
  /// This action manage unwind segue
  @IBAction func unwindSegueToHVC( _ seg: UIStoryboardSegue) {}

  /// This action manage going to ReaderVC
  @IBAction func didTapSearchBTN(_ sender: CustomUIButton) {
    performSegue(withIdentifier: "segueFromHVCtoRVC", sender: self)
  }

  /// This action manage going to MakerVC
  @IBAction func didTapAddBTN(_ sender: CustomUIButton) {
    performSegue(withIdentifier: "segueFromHVCtoMVC", sender: self)
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
