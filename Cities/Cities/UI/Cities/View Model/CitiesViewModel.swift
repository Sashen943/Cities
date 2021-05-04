//
//  CitiesViewModel.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

class CitiesViewModel {
    
    // MARK: Localised string(s)
    
    private let title = "Cities"
    private let fetchCitiesError = "Something went wrong."
    private let fetchCitiesErrorButtonTitle = "Retry"
    private let serachBarPlaceholder = "Search for a city"
    
    // MARK: Dependencies
    
    private var repository: CitiesRepository
    private var view: CitiesView
    
    // MARK: Attribute(s)
    
    private var cities: [City] = []
    var filteredCities: [City] = []
    
    // MARK: Constructor(s)
    
    init(view: CitiesView, repository: CitiesRepository) {
        self.view = view
        self.repository = repository
    }
    
    // MARK: Method(s)
    
    func configureUI() {
        self.view.setTitle(title)
        self.view.configureTableView()
        self.view.configureSearchBar(serachBarPlaceholder)
    }
    
    /// Complexity: O(n log n)
    
    @objc func fetchCities() {
        self.view.showLoadingIndicator()
        AsynchronousProvider.runOnConcurrent({
            self.repository.fetchCities { [weak self] (result) in
                switch result {
                case .success(let cities):
                    let sortedCities = cities.sorted{ $0.name < $1.name }
                    CitiesCache.shared.cacheCities(sortedCities)
                    self?.handleThatFetchCitiesSucceeds(sortedCities)
                case .failure(_):
                    self?.handleThatFetchCitiesFails()
                }
            }
        }, .userInitiated)
    }
    
    private func handleThatFetchCitiesSucceeds(_ cities: [City]) {
        AsynchronousProvider.runOnMain {
            self.cities = cities
            self.filteredCities = cities
            self.view.reloadTableView()
            self.view.hideLoadingIndicator()
        }
    }
    
    private func handleThatFetchCitiesFails() {
        AsynchronousProvider.runOnMain {
            self.view.hideLoadingIndicator()
            self.view.showErrorViewWithRetryAction(self.fetchCitiesError,
                                                   #selector(self.fetchCities),
                                                   self,
                                                   self.fetchCitiesErrorButtonTitle)
        }
    }
    
    func filterCities(_ searchText: String?) {
        AsynchronousProvider.runOnConcurrent ({
            self.performFilter(searchText) { [weak self] (cities) in
                self?.handleThatFilteringHasFinished(cities)
            }
        }, .userInteractive)
    }
    
    private func handleThatFilteringHasFinished(_ cities: [City]) {
        AsynchronousProvider.runOnMain {
            self.filteredCities = cities
            self.view.reloadTableView()
        }
    }
    
    private func performFilter(_ searchText: String?, completion: @escaping ([City]) -> ()) {
        if let searchText = searchText, searchText.count > 0 {
            completion(self.cities.filter { $0.name.starts(with: searchText) })
        } else {
            completion(self.cities)
        }
    }
    
    func didSelectCity(at index: Int) {
        CitiesCache.shared.setSelectedCity(filteredCities[index]._id)
        self.view.navigateToCityScreen()
    }
    
    
}
