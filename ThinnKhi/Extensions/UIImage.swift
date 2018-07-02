//
//  UIImage.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/2.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

extension UIImage {
  func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
