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
  
  // MARK: - Properties
  let weatherData: WeatherData
  let coordinateInfo: CLPlacemark
  
  // MARK: -
  private let dateFormatter = DateFormatter()
  
  var temperature: String {
    let temperature = weatherData.currently.temperature
    
    switch UserDefaults.temperatureNotation() {
    case .fahrenheit:
      return String(format: "%.1f °F", temperature)
    default:
      return String(format: "%.1f °C", temperature.toCelcius())
    }
  }
  
  var precipIntensity: String {
    let precipIntensity = weatherData.currently.precipIntensity
    return String(format: "%f %", precipIntensity)
  }
  
  var humidity: String {
    let humidity = weatherData.currently.humidity
    return String(format: "%f %", humidity)
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

  var image: String {
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

}
