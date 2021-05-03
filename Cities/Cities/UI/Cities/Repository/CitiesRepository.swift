//
//  CitiesRepository.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

protocol CitiesRepository {
    func fetchCities(completion: @escaping (Result<[City], Error>) -> ())
}
