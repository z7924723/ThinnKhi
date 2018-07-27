//
//  LocationsViewLocationViewModel.swift
//  ThinnKhi
//
//  Created by PinguMac on 2018/7/13.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import CoreLocation

struct LocationsViewLocationViewModel {
  
  // MARK: - Properties
  let location: CLLocation?
  let locality: String?
  let locationAsString: String?
  
  // MARK: - Initialization
  init(location: CLLocation? = nil,
       locality: String? = nil ,
       locationAsString: String? = nil) {
    self.location = location
    self.locality = locality
    self.locationAsString = locationAsString
  }
  
}

extension LocationsViewLocationViewModel: LocationRepresentable {
  
  var text: String {
    if let locationAsString = locationAsString {
      return locationAsString
    } else if let location = location {
      return location.asString
    } else if let locality = locality {
      return locality
    }
    
    return "Unknown Location"
  }
  
}

extension CLLocation {
  
  var asString: String {
    let latitude = String(format: "%.3f", coordinate.latitude)
    let longitude = String(format: "%.3f", coordinate.longitude)
    return "\(latitude), \(longitude)"
  }
  
}
