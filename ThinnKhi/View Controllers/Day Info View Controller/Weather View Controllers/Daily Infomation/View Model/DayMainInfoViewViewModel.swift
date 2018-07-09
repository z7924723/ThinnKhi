//
//  DayMainInfoViewViewModel.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/26.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation
import CoreLocation

struct DayMainInfoViewViewModel {
  
  // MARK: - Enum
  enum TemperatureType {
    static let mainTemerature = 1
    static let otherTemerature = 2
  }
  
  // MARK: - Properties
  let weatherData: WeatherData
  let coordinateInfo: CLPlacemark
  
  // MARK: -
  private let dateFormatter = DateFormatter()
  
  var summary: String {
    return String(weatherData.currently.summary)
  }
  
  var currentTemperature: String {
    let currentTemperature = weatherData.currently.temperature

    return temperatureConversion(temperature: currentTemperature, type: TemperatureType.mainTemerature)
  }
  
  var temperatureHigh: String {
    let temperatureHigh = weatherData.daily.data[0].temperatureHigh
    
    return temperatureConversion(temperature: temperatureHigh, type: TemperatureType.otherTemerature)
  }
  
  var temperatureLow: String {
    let temperatureLow = weatherData.daily.data[0].temperatureLow
    
    return temperatureConversion(temperature: temperatureLow, type: TemperatureType.otherTemerature)
  }
  
  var precipProbability: String {
    let precipProbability = weatherData.currently.precipProbability
    return String(format: "%.f %%", precipProbability * 100)
  }
  
  var humidity: String {
    let humidity = weatherData.currently.humidity
    return String(format: "%.f %%", humidity * 100)
  }
  
  var windSpeed: String {
    let windSpeed = weatherData.currently.windSpeed

    switch UserDefaults.unitsNotation() {
    case .imperial:
      return String(format: "%.f MPH", windSpeed)
    default:
      return String(format: "%.f KPH", windSpeed.toKPH())
    }
  }

  var weatherIcon: String {
    return String(weatherData.currently.icon)
  }

  var country: String {
    let country = coordinateInfo.country!
    return String(country)
  }
  
  var city: String {
    let city = coordinateInfo.locality!
    return String(city)
  }
  
  // MARK: - Helper Method
  private func temperatureConversion(temperature: Double, type: Int) -> String {
    switch UserDefaults.temperatureNotation() {
    case .fahrenheit:
      guard type == TemperatureType.otherTemerature else {
        return String(format: "%.1f°F", temperature)
      }
      return String(format: "%.1f°C", temperature)
      
    default:
      guard type == TemperatureType.otherTemerature else {
        return String(format: "%.1f°F", temperature)
      }
      return String(format: "%.1f°C", temperature.toCelcius())
    }
  }

}
