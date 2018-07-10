//
//  ViewSettingViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/10.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class ViewSettingViewController: UIViewController {
  
  // Mark: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBackground()
  }
  
  // MARK: - View Methods
  private func setupBackground() {
    let backgroundLayer = CAGradientLayer().thinnKhiBackgroundColor()
    backgroundLayer.frame = self.view.bounds
    self.view.layer.insertSublayer(backgroundLayer, at: 0)
  }
}
