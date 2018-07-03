//
//  WeekViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import CoreLocation

class WeekInfoViewController: UIViewController {
  
  // MARK: - Porperties
  private var placemark: CLPlacemark?
  
  // MARK: - Initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(showPlacemark),
                                           name: .placemarkDidSet,
                                           object: placemark)
  }

  // Mark: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  // MARK: - Helper
  @objc func showPlacemark(notification: NSNotification) {
    placemark = notification.object as? CLPlacemark
    if let placemark = placemark {
      print(placemark.locality)
    }
  }
}
