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
  
  var numberOfHours: Int {
    return weatherData.data.count
  }
  
  func viewModel(for index: Int) -> HourlyDataViewViewModel {
    return HourlyDataViewViewModel(hourData: weatherData.data[index])
  }

}