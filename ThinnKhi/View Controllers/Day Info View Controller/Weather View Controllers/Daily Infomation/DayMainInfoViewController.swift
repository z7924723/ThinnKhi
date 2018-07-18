//
//  ViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class DayMainInfoViewController: WeatherViewController {
  
  // MARK: - Interface Builder Properties
  @IBOutlet weak var districtLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var temperatureLowLable: UILabel!
  @IBOutlet weak var temperatureHighLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var precipitationLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  
  
  // MARK: - Properties
  var viewModel: DayMainInfoViewViewModel? {
    didSet {
      updateView()
    }
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  // MARK: - Public Interface
  func reloadData() {
    updateView()
  }

  // MARK: - View Methods
  private func updateView() {
    if let viewModel = viewModel {
      let tabBar = self.tabBarController!.tabBar
      
      weatherDataContainer.isHidden = false
      tabBar.isUserInteractionEnabled = true
      
      districtLabel.text = viewModel.city
      weatherIcon.image = UIImage(named: viewModel.weatherIcon)
      summaryLabel.text = viewModel.summary
      temperatureLabel.text = viewModel.currentTemperature
      temperatureHighLabel.text = viewModel.temperatureHigh
      temperatureLowLable.text = viewModel.temperatureLow
      humidityLabel.text = viewModel.humidity
      precipitationLabel.text = viewModel.precipProbability
      windSpeedLabel.text = viewModel.windSpeed
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

