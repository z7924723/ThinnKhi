//
//  DayHoursInfoViewViewModel.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/28.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import Foundation

struct DayHoursInfoViewViewModel {
  
  // MARK: - Properties
  let weatherData: Hourly
  let timeZone: String
  
  var numberOfSection: Int {
    return 1
  }
  
  var numberOfHours: Int {
    return 24
  }
  
  func viewModel(for index: Int) -> HourlyDataViewViewModel {
    return HourlyDataViewViewModel(hourData: weatherData.data[index], timeZone: timeZone)
  }

}
