//
//  CityServiceImplementation.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

class CityServiceImplementation: CityService {
    
    // MARK: Attribute(s)
    
    private let GENERIC_ERROR = NSError(domain: "CityService.GenericError", code: 1, userInfo: nil)
    private let fileName = "cities"
    private let fileType = "json"
    
    // MARK: Method(s)
    
    func fetchCities(completion: @escaping (Result<[City], Error>) -> ()) {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            let fileUrl = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decodedCities = try JSONDecoder().decode([City].self, from: data)
                completion(.success(decodedCities))
            } catch(let error) {
                debugPrint("CityService - \(error.localizedDescription)")
                completion(.failure(error))
            }
        } else {
            debugPrint("CityService - could not find file \(fileName).\(fileType)")
            completion(.failure(GENERIC_ERROR))
        }
    }
}
