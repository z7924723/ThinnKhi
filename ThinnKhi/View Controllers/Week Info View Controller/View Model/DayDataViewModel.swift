//
//  DayDataViewModel.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/5.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

class DayDataViewModel {
  
  // MARK: - Properties
  let dayData: DayData
  var isCollapsed: Bool
  
  var isCollapsible: Bool {
    return true
  }
  
  // MARK: -
  private let dayFormatter = DateFormatter()
  private let dateFormatter = DateFormatter()
  
  var day: String {
    let date = Date(timeIntervalSince1970: dayData.time)
    dayFormatter.dateFormat = "EEE"
    
    return dayFormatter.string(from: date)
  }
  
  var date: String {
    let date = Date(timeIntervalSince1970: dayData.time)
    dateFormatter.dateFormat = "MM/dd"
    
    return dateFormatter.string(from: date)
  }
  
  var summary: String {
    return String(dayData.summary)
  }
  
  var temperatureHigh: String {
    let temperatureHigh = dayData.temperatureHigh
    
    return temperatureConversion(temperature: temperatureHigh)
  }
  
  var temperatureLow: String {
    let temperatureLow = dayData.temperatureLow
    
    return temperatureConversion(temperature: temperatureLow)
  }
  
  var precipProbability: String {
    let precipProbability = dayData.precipProbability
    return String(format: "%.f %%", precipProbability * 100)
  }
  
  var humidity: String {
    let humidity = dayData.humidity
    return String(format: "%.f %%", humidity * 100)
  }
  
  var windSpeed: String {
    let windSpeed = dayData.windSpeed
    
    switch UserDefaults.unitsNotation() {
    case .imperial:
      return String(format: "%.f MPH", windSpeed)
    default:
      return String(format: "%.f KPH", windSpeed.toKPH())
    }
  }
  
  var weatherIcon: String {
    return String(dayData.icon)
  }
  
  // MARK: - Initializers
  init(dayData: DayData, isCollapsed: Bool = true) {
    self.dayData = dayData
    self.isCollapsed = isCollapsed
  }
  
  // MARK: - Helper Method
  private func temperatureConversion(temperature: Double) -> String {
    switch UserDefaults.temperatureNotation() {
    case .fahrenheit:
      return String(format: "%.f °", temperature.rounded())
    default:
      return String(format: "%.f °", temperature.toCelcius().rounded())
    }
  }
  
}
