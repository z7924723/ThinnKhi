//
//  RootViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import CoreLocation

class DayInfoViewController: ViewSettingViewController {
  
  // MARK: - Segues
  private enum Segue {
    static let segueDayMainInfoView = "SegueDayMainInfoView"
    static let SegueDayHoursInfoView = "SegueDayHoursInfoView"
//    static let SegueSettingsView = "SegueSettingsView"
    static let segueLocationsView = "SegueLocationsView"
  }
  
  // MARK: - Properties
  @IBOutlet private var dayMainInfoViewController: DayMainInfoViewController!
  @IBOutlet private var dayHoursInfoViewController: DayHoursInfoViewController!
  
  // MARK: -
  private lazy var dataManager = {
    return DataManager(baseURL: API.AuthenticatedBaseURL)
  }()
  
  private var currentLocation: CLLocation? {
    didSet {
      coordinateTransform(location: currentLocation!)
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
  
  private var placemark: CLPlacemark? {
    didSet {
      NotificationCenter.default.post(name: .placemarkDidSet, object: placemark)

      fetchWeatherData()
    }
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTabBar()

    setupNotificationHandling()
    
  }
  
  private func setupTabBar() {
    let tabBar = self.tabBarController!.tabBar
    let tabButtonLineColors = #colorLiteral(red: 0.9411764706, green: 0.1019607843, blue: 0.1882352941, alpha: 1)
    tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: tabButtonLineColors, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineWidth: 2.0)
    
    tabBar.isUserInteractionEnabled = false
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else { return }
    
    switch identifier {
    case Segue.segueDayMainInfoView:
      guard let destination = segue.destination as? DayMainInfoViewController else {
        fatalError("Unexpected Destination View Controller")
      }
      
      self.dayMainInfoViewController = destination
      
    case Segue.SegueDayHoursInfoView:
      guard let destination = segue.destination as? DayHoursInfoViewController else {
        fatalError("Unexpected Destination View Controller")
      }
      
      self.dayHoursInfoViewController = destination

    case Segue.segueLocationsView:
      guard let navigationController = segue.destination as? UINavigationController else {
        fatalError("Unexpected Destination View Controller")
      }
      
      guard let destination = navigationController.topViewController as? LocationsViewController else {
        fatalError("Unexpected Destination View Controller")
      }

      destination.currentLocation = currentLocation
      destination.currentLocality = placemark?.locality
      destination.delegate = self
      
    default:
      break
    }
  }
    
  // MARK: - Unwind Actions
  @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    
  }
  
  // MARK: - Notification Handling
  @objc func applicationDidBecomeActive(_ notification: Notification) {
    requestLocation()
  }
  
  // MARK: - Helper Methods
  private func fetchWeatherData() {
    guard let location = currentLocation else { return }
    
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    
    dataManager.weatherDataForLocation(latitude: latitude, longitude: longitude) { (weatherData, error) in
      if let error = error {
        print(error)
      } else if let weatherData = weatherData {
        NotificationCenter.default.post(name: .weatherDataDidSet, object: weatherData.daily)
        
        self.dayMainInfoViewController.viewModel = DayMainInfoViewViewModel(weatherData: weatherData, coordinateInfo: self.placemark!)

        self.dayHoursInfoViewController.viewModel = DayHoursInfoViewViewModel(weatherData: weatherData.hourly)
        
      }
    }
  }
  
  private func coordinateTransform (location: CLLocation) {
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      if error == nil {
        self.placemark = placemarks![0]
      }
    }
  }
  
  private func setupNotificationHandling() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(DayInfoViewController.applicationDidBecomeActive(_:)),
                                   name: Notification.Name.UIApplicationDidBecomeActive,
                                   object: nil)
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

extension DayInfoViewController: CLLocationManagerDelegate {
  
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

extension DayInfoViewController: LocationsViewControllerDelegate {
  
  func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation) {
    // Update Current Location
    currentLocation = location
  }
  
}
