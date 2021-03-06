//
//  Configuration.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/26.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

struct Defaults {
  static let Latitude: Double = 25.051578
  static let Longitude: Double = 121.534092
}

struct API {
  
  private init() {}
  
  static let APIKey = "3f8f57a00ad03b0f969cebf7178db3aa"
  static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
  
  static var AuthenticatedBaseURL: URL {
    return BaseURL.appendingPathComponent(APIKey)
  }
  
}
