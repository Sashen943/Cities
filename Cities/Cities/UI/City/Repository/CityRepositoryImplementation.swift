//
//  CityRepositoryImplementation.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

class CityRepositoryImplementation: CityRepository {
    
    // MARK: Attribute(s)
    
    private let NO_CITIES_ERROR = NSError(domain: "CityRepository - no cities", code: 0, userInfo: nil)
    private let CITY_NOT_FOUND_ERROR = NSError(domain: "CityRepository - no cities", code: 0, userInfo: nil)

    // MARK: Method(s)

    func fetchCity(cityId: Int, completion: @escaping (Result<City, Error>) -> ()) {
        let cities = CitiesCache.shared.cities
        if cities.count > 0 {
            guard let city = cities.first(where: {$0._id == cityId }) else {
                completion(.failure(CITY_NOT_FOUND_ERROR))
                return
            }
            completion(.success(city))
        } else {
            completion(.failure(NO_CITIES_ERROR))
        }
    }
    
}

