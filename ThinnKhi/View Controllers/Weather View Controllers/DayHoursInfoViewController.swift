//
//  WeatherViewController.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/6/25.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class DayHoursInfoViewController: WeatherViewController {
  
  // MARK: - Interface Builder Properties
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Properties
  var viewModel: DayHoursInfoViewViewModel? {
    didSet {
      updateView()
    }
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - View Methods
  private func updateView() {
    if let _ = viewModel {
      weatherDataContainer.isHidden = false
    }
  }
}

extension DayHoursInfoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let viewModel = viewModel else {
      return 0
    }
    return viewModel.numberOfHours
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCollectionViewCell.reuseIdentifier, for: indexPath) as? HourInfoCollectionViewCell else {
      fatalError("Unexpected Collection View Cell")
    }
    
    if let viewModel = viewModel?.viewModel(for: indexPath.row) {
      cell.configure(withViewModel: viewModel)
    }
    
    return cell
  }
}
