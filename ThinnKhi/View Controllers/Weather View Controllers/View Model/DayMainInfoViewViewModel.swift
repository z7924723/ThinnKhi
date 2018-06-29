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
  
  var currentTemperature: String {
    let currentTemperature = weatherData.currently.temperature

    return temperatureConversion(temperature: currentTemperature)
  }
  
  var temperatureHigh: String {
    let temperatureHigh = weatherData.daily.data[0].temperatureHigh
    
    return temperatureConversion(temperature: temperatureHigh)
  }
  
  var temperatureLow: String {
    let temperatureLow = weatherData.daily.data[0].temperatureLow
    
    return temperatureConversion(temperature: temperatureLow)
  }
  
  var precipIntensity: String {
    let precipIntensity = weatherData.currently.precipIntensity
    return String(format: "%.f %%", precipIntensity * 100)
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
  private func temperatureConversion(temperature: Double) -> String {
    switch UserDefaults.temperatureNotation() {
    case .fahrenheit:
      return String(format: "%.1f °F", temperature)
    default:
      return String(format: "%.1f °C", temperature.toCelcius())
    }
  }

}
