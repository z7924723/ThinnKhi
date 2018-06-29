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
  let HourlyData: Hourly
  
  var numberOfHours: Int {
    return HourlyData.data.count
  }
  
  func viewModel(for index: Int) -> HourlyDataViewViewModel {
    return HourlyDataViewViewModel(hourData: HourlyData.data[index])
  }

}
