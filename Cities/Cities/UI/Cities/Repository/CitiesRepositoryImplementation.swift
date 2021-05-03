//
//  CitiesRepositoryImplementation.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

class CitiesRepositoryImplementation: CitiesRepository {
    
    // MARK: Dependencies
    
    private let service = CityServiceImplementation()
    
    // MARK: Method(s)
    
    func fetchCities(completion: @escaping (Result<[City], Error>) -> ()) {
        self.service.fetchCities { (result) in
            switch result {
            case .success(let cities):
                completion(.success(cities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
