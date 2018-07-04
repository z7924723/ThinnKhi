//
//  WeatherViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/28.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var weatherDataContainer: UIView!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  // MARK: - View Methods
  private func setupView() {
    weatherDataContainer.isHidden = true
  }
}
