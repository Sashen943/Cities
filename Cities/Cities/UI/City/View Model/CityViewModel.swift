//
//  CityViewModel.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import Foundation
import CoreLocation

class CityViewModel {
    
    // MARK: Localised string(s)
    
    private let title = "City"
    private let fetctCityError = "Could not find city."
    private let fetchCityErrorButtonTitle = "Go back"
    
    // MARK: Dependencies
    
    private var repository: CityRepository
    private var view: CityView
    
    // MARK: Attribute(s)
    
    private var city: City?
    private let selectedCityId = CitiesCache.shared.selectedCityId
    
    // MARK: Constructor(s)
    
    init(_ repository: CityRepository, _ view: CityView) {
        self.view = view
        self.repository = repository
    }
    
    // MARK: Method(s)
    
    func configureUI() {
        
    }
    
    func fetchCity() {
        self.view.showLoadingIndicator()
        AsynchronousProvider.runOnConcurrent({
            self.repository.fetchCity(cityId: self.selectedCityId) { [weak self] (result) in
                switch result {
                case .success(let city):
                    self?.handleThatCityIsSuccessfullyFetched(city)
                case .failure(_):
                    self?.handleThatCityIsNotSuccessfullyFetched()
                }
            }
        }, .userInitiated)
        
    }
    
    func handleThatCityIsSuccessfullyFetched(_ city: City) {
        AsynchronousProvider.runOnMain {
            self.view.hideLoadingIndicator()
            self.city = city
            self.view.setTitle(city.name)
            let location = CLLocation(latitude: city.coord.lat,
                                         longitude: city.coord.lon)
            self.view.configureMap(location, city.name)
        }
    }
    
    func handleThatCityIsNotSuccessfullyFetched() {
        AsynchronousProvider.runOnMain {
            self.view.hideLoadingIndicator()
            self.view.showErrorViewWithRetryAction(self.fetctCityError,
                                                   #selector(self.goBack),
                                                   self,
                                                   self.fetchCityErrorButtonTitle)
        }
    }
    
    @objc func goBack() {
        self.view.navigationController?.popViewController(animated: true)
    }
}
