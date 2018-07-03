//
//  HoursInfoCollectionViewCell.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/26.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class HourInfoCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Type Properties
  static let reuseIdentifier = "WeatherHourCell"
  
  // MARK: - Properties
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  
  // MARK: - Initialization
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Configuration
  func configure(withViewModel viewModel: HourlyDataViewViewModel) {
    timeLabel.text = viewModel.time
    temperatureLabel.text = viewModel.temperature
    weatherIcon.image = UIImage(named: viewModel.weatherIcon)
  }

}
