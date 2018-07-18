//
//  WeekViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit
import CoreLocation

class WeekInfoViewController: ViewSettingViewController {
  
  // MARK: - Interface Builder Properties
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var districtLabel: UILabel!
  
  // MARK: - Porperties
  private var placemark: CLPlacemark?
  private var weekInfo: Daily?
  private var weatherDayData: [DayData]?
  
  // MARK: -
  private var viewModel: [DayDataViewModel]?

  
  // MARK: - Initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    configureObserver()
  }

  // Mark: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    registerTableViewCell()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    configViewModel()
    
    districtLabel.text = placemark?.locality

    configNavigationBarItem()
  }
  
  // MARK: - Actions
  @IBAction func temperatureNotation(_ sender: Any) {
    if UserDefaults.temperatureNotation() == TemperatureNotation.celsius {
      UserDefaults.setTemperatureNotation(temperatureNotation: .fahrenheit)
      self.navigationItem.rightBarButtonItem?.title = "°C"
    } else {
      UserDefaults.setTemperatureNotation(temperatureNotation: .celsius)
      self.navigationItem.rightBarButtonItem?.title = "°F"
    }
    
    tableView.reloadData()
  }
  
  // MARK: - Helper
  private func configNavigationBarItem() {
    if UserDefaults.temperatureNotation() == TemperatureNotation.celsius {
      self.navigationItem.rightBarButtonItem?.title = "°F"
    } else {
      self.navigationItem.rightBarButtonItem?.title = "°C"
    }
  self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Roboto-Medium", size: 25)!], for: .normal)
    
    tableView.reloadData()
  }
  
  private func configViewModel() {
    viewModel = [DayDataViewModel]()

    // get seven days of data
    for index in 1..<(weatherDayData?.count)! {
      viewModel?.append(DayDataViewModel(dayData: weatherDayData![index]))
    }
    
    viewModel?.first?.isCollapsed = false
  }
  
  private func registerTableViewCell() {
    let headerNib = UINib.init(nibName: "WeekInfoTableViewSectionHeader", bundle: Bundle.main)
    tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "WeekInfoTableViewSectionHeader")
    
    tableView?.register(WeekInfoTableViewCell.nib, forCellReuseIdentifier: WeekInfoTableViewCell.identifier)
  }
  
  private func configureObserver() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(getPlacemark),
                                           name: .placemarkDidSet,
                                           object: placemark)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(getWeatherData),
                                           name: .weatherDataDidSet,
                                           object: weekInfo)
  }
  
  @objc func getPlacemark(notification: NSNotification) {
    placemark = notification.object as? CLPlacemark
  }
  
  @objc func getWeatherData (notification: NSNotification) {
    let dailyInfo = notification.object as? Daily
    
    weatherDayData = [DayData]()
    for index in 0..<(dailyInfo?.data.count)! {
      weatherDayData?.append((dailyInfo?.data[index])!)
    }
  }
}

extension WeekInfoViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeekInfoTableViewSectionHeader") as! WeekInfoTableViewSectionHeader

    headerView.delegate = self
    headerView.section = section

    if let viewModel = viewModel?[section] {
      headerView.configure(withViewModel: viewModel)
    }
    
    return headerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
  
}

extension WeekInfoViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let viewModel = viewModel else {
      return 0
    }

    return viewModel.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = viewModel else {
      return 0
    }

    let cellData = viewModel[section]
    
    return cellData.isCollapsed ? 0 : 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekInfoTableViewCell.identifier, for: indexPath) as? WeekInfoTableViewCell else {
      fatalError("Unexpected Table View Cell")
    }
    
    if let viewModel = viewModel?[indexPath.section] {
      cell.configure(withViewModel: viewModel)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.transform = CGAffineTransform(scaleX: 1, y: 0)
    UIView.animate(withDuration: 0.5) {
      cell.transform = CGAffineTransform.identity
    }
  }
}

extension WeekInfoViewController: HeaderViewDelegate {
  
  func toggleSection(header: WeekInfoTableViewSectionHeader, section: Int) {

    for index in 0...(viewModel?.count)! - 1 {
      if index == section {
        viewModel![index].isCollapsed = false
      } else {
        viewModel![index].isCollapsed = true
      }
    }
    
    self.tableView.reloadData()
    
    let indexPath = IndexPath(row: tableView.numberOfRows(inSection: section) - 1, section: section)
    self.tableView.scrollToRow(at: indexPath , at: .top, animated: true)
  }
  
}
