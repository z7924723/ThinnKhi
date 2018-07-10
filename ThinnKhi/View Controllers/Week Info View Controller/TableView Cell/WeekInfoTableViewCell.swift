//
//  WeekInfoTableViewCell.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/4.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class WeekInfoTableViewCell: UITableViewCell {
  
  // MARK: - Porperties
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var precipitationLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  static var identifier: String {
    return String(describing: self)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
//  override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//    
//    // Configure the view for the selected state
//  }
  
  func configure(withViewModel viewModel: DayDataViewModel) {
    self.summaryLabel.text = viewModel.summary
    self.humidityLabel.text = viewModel.humidity
    self.precipitationLabel.text = viewModel.precipProbability
    self.windSpeedLabel.text = viewModel.windSpeed
  }
  
}
