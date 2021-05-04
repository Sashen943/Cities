//
//  CityView.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation
import CoreLocation

protocol CityView: BaseViewController {
    func configureMap(_ location: CLLocation, _ name: String)
}
