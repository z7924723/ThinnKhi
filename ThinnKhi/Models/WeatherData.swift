//
//  WeatherData.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/26.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
  let latitude: Double
  let longitude: Double
  let timezone: String
  let currently: Currently
  let daily: Daily
  let hourly: Hourly
}

struct Currently: Codable {
  let time: Date
  let summary: String
  let icon: String
  let temperature: Double
  let precipProbability: Double
  let humidity: Double
  let windSpeed: Double
}

struct Daily: Codable {
  let data: [DayData]
}

struct DayData: Codable {
  let time: Double
  let icon: String
  let summary: String
  let temperatureHigh: Double
  let temperatureLow: Double
  let humidity: Double
  let precipProbability: Double
  let windSpeed: Double
}

struct Hourly: Codable {
  let data: [HourData]
}

struct HourData: Codable {
  let time: Date
  let icon: String
  let temperature: Double
  let precipIntensity: Double
}
