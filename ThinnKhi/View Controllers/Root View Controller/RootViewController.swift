//
//  RootViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
  // MARK: - Segues
  private enum Segue {
    static let segueDayMainInfoView = "SegueDayMainInfoView"
    static let SegueDayHoursInfoView = "SegueDayHoursInfoView"
    static let SegueSettingsView = "SegueSettingsView"
    static let segueLocationsView = "SegueLocationsView"
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let backgroundLayer = CAGradientLayer().thinnKhiBackgroundColor()
    backgroundLayer.frame = self.view.bounds
    self.view.layer.insertSublayer(backgroundLayer, at: 0)
  }
  
  // MARK: - Unwind Actions
  @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    
  }
}
