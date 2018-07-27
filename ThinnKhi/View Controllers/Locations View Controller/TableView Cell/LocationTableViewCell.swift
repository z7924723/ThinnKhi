//
//  LocationTableViewCell.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/12.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
  
  // MARK: - Type Properties
  static let reuseIdentifier = "LocationCell"
  
  // MARK: - Properties
  @IBOutlet var mainLabel: UILabel!
  
  // MARK: - Initialization
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Configuration
  func configure(withViewModel viewModel: LocationRepresentable) {
    mainLabel.text = viewModel.text
  }
  
}

