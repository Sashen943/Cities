//
//  CitiesCache.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation

class CitiesCache {
    
    // MARK: Attribute(s)
    
    static let shared = CitiesCache()
    var cities: [City] = []
    var selectedCityId: Int = 0
    
    // MARK: Constructor(s)
    
    private init() {}
    
    // MARK: Method(s)
    
    func cacheCities(_ cities: [City]) {
        self.cities = cities
    }
    
    func setSelectedCity(_ cityId: Int) {
        self.selectedCityId = cityId
    }
    
}
