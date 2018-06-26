//
//  Conversions.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/27.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

extension Double {
  
  func toCelcius() -> Double {
    return ((self - 32.0) / 1.8)
  }
  
  func toKPH() -> Double {
    return (self * 1.609344)
  }
  
}
