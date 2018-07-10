//
//  WeekInfoTableViewSectionHeader.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/4.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
  func toggleSection(header: WeekInfoTableViewSectionHeader, section: Int)
}

class WeekInfoTableViewSectionHeader: UITableViewHeaderFooterView {
  
  // MARK: - Porperties
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var temperatureHighLabel: UILabel!
  @IBOutlet weak var temperatureLowLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  
  // Mark: -
  var delegate: HeaderViewDelegate?
  var section: Int = 0
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  static var identifier: String {
    return String(describing: self)
  }
  
  // MARK: - Initialization
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
  }
  
  // MARK: -
  @objc private func didTapHeader() {
    delegate?.toggleSection(header: self, section: section)
  }
  
  // MARK: - Configuration
  func configure(withViewModel viewModel: DayDataViewModel) {
    dateLabel.text = viewModel.date
    dayLabel.text = viewModel.day
    temperatureHighLabel.text = viewModel.temperatureHigh
    temperatureLowLabel.text = viewModel.temperatureLow
    weatherIcon.image =  UIImage(named: viewModel.weatherIcon)
  }
}
