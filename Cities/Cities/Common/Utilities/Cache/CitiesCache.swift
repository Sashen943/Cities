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
    
    // MARK: Constructor(s)
    
    private init() {}
    
    // MARK: Method(s)
    
    func cacheCities(_ cities: [City]) {
        self.cities = cities
    }
    
}
