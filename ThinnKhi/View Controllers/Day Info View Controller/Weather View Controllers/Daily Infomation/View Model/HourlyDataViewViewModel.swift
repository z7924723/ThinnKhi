//
//  HoursDataViewViewModel.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/28.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

struct HourlyDataViewViewModel {
  
  // MARK: - Properties
  let hourData: HourData
  let timeZone: String
  
  // MARK: -
  private let hourFormatter = DateFormatter()
  
  var time: String {
    hourFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
    hourFormatter.timeZone = TimeZone(identifier: timeZone)
    
    return hourFormatter.string(from: hourData.time)
  }
  
  var temperature: String {
    let temperature = hourData.temperature
    
    return temperatureConversion(temperature: temperature)
  }
  
  var weatherIcon: String {
    return String(hourData.icon)
  }
  
  var precipIntensity: String {
    let precipIntensity = hourData.precipIntensity
    return String(format: "%.f %%", precipIntensity * 100)
  }
  
  // MARK: - Helper Method
  private func temperatureConversion(temperature: Double) -> String {
    switch UserDefaults.temperatureNotation() {
    case .fahrenheit:
      return String(format: "%.f°", temperature.rounded())
    default:
      return String(format: "%.f°", temperature.toCelcius().rounded())
    }
  }

}
