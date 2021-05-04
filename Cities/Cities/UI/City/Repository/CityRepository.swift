//
//  CityRepository.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

protocol CityRepository {
    func fetchCity(cityId: Int, completion: @escaping (Result<City, Error>) -> ())
}
