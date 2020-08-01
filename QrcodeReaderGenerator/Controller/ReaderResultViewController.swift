//
//  ReaderResultViewController.swift
//  QrcodeReaderGenerator
//
//  Created by Lucas Lombard on 01/08/2020.
//  Copyright © 2020 Lucas Lombard. All rights reserved.
//

import UIKit

class ReaderResultViewController: UIViewController {

  // MARK: - Properties
  var result: [String] = []

  // MARK: - Outlets
  @IBOutlet weak var resultLB: UILabel!

  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    resultLB.text = result.first
  }
}
