//
//  CAGradientLayer.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

extension CAGradientLayer {
  
  func thinnKhiBackgroundColor() -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    let gradientColors = [#colorLiteral(red: 0, green: 0.4470588235, blue: 0.5450980392, alpha: 1), #colorLiteral(red: 0, green: 0.5490196078, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.2431372549, green: 0.7882352941, blue: 0.7490196078, alpha: 1)]
    
    gradientLayer.colors = gradientColors.map { $0.cgColor }
    
    return gradientLayer
  }
  
}
