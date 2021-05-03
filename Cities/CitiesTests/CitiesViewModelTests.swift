//
//  CitiesViewModelTests.swift
//  CitiesTests
//
//  Created by Sashen Pillay on 2021/05/04.
//

import XCTest

class CitiesViewModelTests: XCTestCase {

    // MARK: Attribute(s)
    
    var systemUnderTest = CitiesViewModel(view: MockedCitiesView())

    // MARK: Lifecycle
    
    override class func setUp() {
        systemUnderTest.repository = MockedCitiesRepository()
    }
    
    func testThatWhenFilteredDataIsSearchedWith
    
    override class func tearDown() {
        
    }

}

class MockedCitiesView: BaseViewController, CitiesView {

    func reloadTableView() {}
    
    func didUpdateSearchValue(_ value: String) {}
    
    func configureTableView() {}
    
    func configureSearchBar() {}
}

class MockedCitiesRepository: CitiesRepository {
    func fetchCities(completion: @escaping (Result<[City], Error>) -> ()) {
        let cities = [City(country: "ZA", name: "Johannesburg", _id: 0, coord: Coord(lon: 2.0, lat: 2.0)),
                      City(country: "ZA", name: "Durban", _id: 1, coord: Coord(lon: 2.0, lat: 2.0)),
                      City(country: "ZA", name: "Cape Town", _id: 2, coord: Coord(lon: 2.0, lat: 2.0)),
                      City(country: "ZA", name: "Port Elizabeth", _id: 3, coord: Coord(lon: 2.0, lat: 2.0))]
        completion(.success(cities))
    }
}
