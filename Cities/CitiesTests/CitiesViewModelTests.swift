//
//  CitiesViewModelTests.swift
//  CitiesTests
//
//  Created by Sashen Pillay on 2021/05/04.
//

import XCTest
import Foundation

class CitiesViewModelTests: XCTestCase {
    
    // MARK: Attribute(s)
    
    var mockedRepository = MockedCitiesRepository()
    
    // MARK: Lifecycle
    
    override class func setUp() {
        AsynchronousProvider.setAsyncRunner(DummyAsynchronousRunner())
    }
    
    func testThatCitiesAreReturnedAlphabetically() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        XCTAssertEqual(systemUnderTest.filteredCities[0].name, "Cape Town")
        XCTAssertEqual(systemUnderTest.filteredCities[1].name, "Durban")
        XCTAssertEqual(systemUnderTest.filteredCities[2].name, "Johannesburg")
        XCTAssertEqual(systemUnderTest.filteredCities[3].name, "Port Elizabeth")
    }
    
    func testThatWhenFilterIsAnEmptyStringThatAllCitiesAreReturned() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        systemUnderTest.filterCities("")
        let expectedResult = 4
        let actualResult = systemUnderTest.filteredCities.count
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testThatWhenFilterIsAnEmptyThatAllCitiesAreReturned() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        systemUnderTest.filterCities(nil)
        let expectedResult = 4
        let actualResult = systemUnderTest.filteredCities.count
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testThatWhenOneCharacterIsFilteredTheCorrectCitiesAreReturned() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        systemUnderTest.filterCities("J")
        let expectedResult = "Johannesburg"
        let actualResult = systemUnderTest.filteredCities[0].name
        XCTAssertEqual(actualResult, expectedResult)
        XCTAssertEqual(systemUnderTest.filteredCities.count, 1)
    }
    
    func testThatWhenTwoCharactersAreFilteredTheCorrectCitiesAreReturned() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        systemUnderTest.filterCities("Du")
        let expectedResult = "Durban"
        let actualResult = systemUnderTest.filteredCities[0].name
        XCTAssertEqual(actualResult, expectedResult)
        XCTAssertEqual(systemUnderTest.filteredCities.count, 1)
    }
    
    func testThatWhenACharacterThatDoesntExistIsFilteredThatNoCitiesAreReturned() {
        let systemUnderTest = CitiesViewModel(view: MockedCitiesView(),
                                              repository: mockedRepository)
        systemUnderTest.fetchCities()
        systemUnderTest.filterCities("Z")
        let expectedResult = 0
        let actualResult = systemUnderTest.filteredCities.count
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    override class func tearDown() {
        AsynchronousProvider.reset()
        super.tearDown()
    }
    
}

class MockedCitiesView: BaseViewController, CitiesView {
    
    func reloadTableView() {}
    
    func navigateToCityScreen(_ city: City) {}
    
    func configureTableView() {}
    
    func configureSearchBar(_ placeholder: String) {}
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

public protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    public func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}

final class MockDispatchQueue: DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
