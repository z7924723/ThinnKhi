//
//  RootViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
  
  // MARK: - Segues
  private enum Segue {
    static let segueDayMainInfoView = "SegueDayMainInfoView"
    static let SegueDayHoursInfoView = "SegueDayHoursInfoView"
    static let SegueSettingsView = "SegueSettingsView"
    static let segueLocationsView = "SegueLocationsView"
  }
  
  // MARK: - Properties
  private var currentLocation: CLLocation? {
    didSet {
      fetchWeatherData()
    }
  }
  
  private lazy var locationManager: CLLocationManager = {
    // Initialize Location Manager
    let locationManager = CLLocationManager()
    
    // Configure Location Manager
    locationManager.distanceFilter = 1000.0
    locationManager.desiredAccuracy = 1000.0
    
    return locationManager
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let backgroundLayer = CAGradientLayer().thinnKhiBackgroundColor()
    backgroundLayer.frame = self.view.bounds
    self.view.layer.insertSublayer(backgroundLayer, at: 0)
    
    setupNotificationHandling()
  }
  
  // MARK: - Unwind Actions
  @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    
  }
  
  // MARK: - Notification Handling
  @objc func applicationDidBecomeActive(notification: Notification) {
    requestLocation()
  }
  
  // MARK: - Helper Methods
  private func fetchWeatherData() {
    
  }
  
  private func setupNotificationHandling() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
  }
  
  private func requestLocation() {
    // Configure Location Manager
    locationManager.delegate = self
    
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      // Request Current Location
      locationManager.requestLocation()
      
    } else {
      // Request Authorization
      locationManager.requestWhenInUseAuthorization()
    }
  }
}

extension RootViewController: CLLocationManagerDelegate {
  
  // MARK: - Authorization
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      // Request Location
      manager.requestLocation()
      
    } else {
      // Fall Back to Default Location
      currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
    }
  }
  
  // MARK: - Location Updates
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      // Update Current Location
      currentLocation = location
      
      // Reset Delegate
      manager.delegate = nil
      
      // Stop Location Manager
      manager.stopUpdatingLocation()
      
    } else {
      // Fall Back to Default Location
      currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    
    if currentLocation == nil {
      // Fall Back to Default Location
      currentLocation = CLLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude)
    }
  }
}
