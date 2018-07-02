//
//  UserDefaults.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/26.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

enum TimeNotation: Int {
  case twentyFourHour
  
  var timeFormat: String {
    switch self {
    default:
      return "HH:mm"
    }
  }
}

enum UnitsNotation: Int {
  case imperial
  case metric
}

enum TemperatureNotation: Int {
  case fahrenheit
  case celsius
}

extension UserDefaults {
  
  enum Keys {
    static let locations = "locations"
    static let timeNotation = "timeNotation"
    static let unitsNotation = "unitsNotation"
    static let temperatureNotation = "temperatureNotation"
  }
  
  // MARK: - Time Notation
  static func timeNotation() -> TimeNotation {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.timeNotation)
    return TimeNotation(rawValue: storedValue) ?? TimeNotation.twentyFourHour
  }
  
  static func setTimeNotation(timeNotation: TimeNotation) {
    UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaults.Keys.timeNotation)
  }
  
  // MARK: - Units Notation
  static func unitsNotation() -> UnitsNotation {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.unitsNotation)
    return UnitsNotation(rawValue: storedValue) ?? UnitsNotation.imperial
  }
  
  static func setUnitsNotation(unitsNotation: UnitsNotation) {
    UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaults.Keys.unitsNotation)
  }
  
  // MARK: - Temperature Notation
  static func temperatureNotation() -> TemperatureNotation {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.temperatureNotation)
    return TemperatureNotation(rawValue: storedValue) ?? TemperatureNotation.fahrenheit
  }
  
  static func setTemperatureNotation(temperatureNotation: TemperatureNotation) {
    UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaults.Keys.temperatureNotation)
  }
  
}

extension UserDefaults {
  
  // MARK: - Locations
  static func loadLocations() -> [Location] {
    guard let dictionaries = UserDefaults.standard.array(forKey: UserDefaults.Keys.locations) as? [ [String: Any] ] else {
      return []
    }
    
    return dictionaries.compactMap({ (dictionary) -> Location? in
      return Location(dictionary: dictionary)
    })
  }
  
  static func addLocation(_ location: Location) {
    // Load Locations
    var locations = loadLocations()
    
    // Add Location
    locations.append(location)
    
    // Save Locations
    saveLocations(locations)
  }
  
  static func removeLocation(_ location: Location) {
    // Load Locations
    var locations = loadLocations()
    
    // Fetch Location Index
    guard let index = locations.index(of: location) else {
      return
    }
    
    // Remove Location
    locations.remove(at: index)
    
    // Save Locations
    saveLocations(locations)
  }
  
  // MARK: -
  private static func saveLocations(_ locations: [Location]) {
    // Transform Locations
    let dictionaries: [ [String: Any] ] = locations.map{ $0.asDictionary }
    
    // Save Locations
    UserDefaults.standard.set(dictionaries, forKey: UserDefaults.Keys.locations)
  }
  
}
