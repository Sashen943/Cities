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
    
    // MARK: Dependencies
    
    var repository: CitiesRepository = CitiesRepositoryImplementation()
    private var view: CitiesView
    
    // MARK: Attribute(s)
    
    private var cities: [City] = []
    var filteredCities: [City] = []
    
    // MARK: Constructor(s)
    
    init(view: CitiesView) {
        self.view = view
    }
    
    // MARK: Method(s)
    
    func configureUI() {
        self.view.setTitle(title)
        self.view.configureTableView()
        self.view.configureSearchBar()
    }
    
    /// Complexity: O(n log n)
    
    @objc func fetchCities() {
        self.view.showLoadingIndicator()
        DispatchQueue.global(qos: .background).async {
            self.repository.fetchCities { [weak self] (result) in
                switch result {
                case .success(let cities):
                    let sortedCities = cities.sorted{ $0.name < $1.name }
                    self?.handleThatFetchCitiesSucceeds(sortedCities)
                case .failure(_):
                    self?.handleThatFetchCitiesFails()
                }
            }
        }
    }
    
    private func handleThatFetchCitiesSucceeds(_ cities: [City]) {
        DispatchQueue.main.async {
            self.cities = cities
            self.filteredCities = cities
            self.view.reloadTableView()
            self.view.hideLoadingIndicator()
        }
    }
    
    private func handleThatFetchCitiesFails() {
        DispatchQueue.main.async {
            self.view.hideLoadingIndicator()
            self.view.showErrorViewWithRetryAction(self.fetchCitiesError,
                                                   #selector(self.fetchCities),
                                                   self,
                                                   self.fetchCitiesErrorButtonTitle)
        }
    }
    
    func filterCities(_ searchText: String?) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.performFilter(searchText) { [weak self] (cities) in
                self?.handleThatFilteringHasFinished(cities)
            }
        }
    }
    
    private func handleThatFilteringHasFinished(_ cities: [City]) {
        DispatchQueue.main.async {
            self.filteredCities = cities
            self.view.reloadTableView()
            self.view.hideLoadingIndicator()
        }
    }

    func performFilter(_ searchText: String?, completion: @escaping ([City]) -> ()) {
        if let searchText = searchText, searchText.count > 0 {
            completion(self.cities.filter { $0.name.starts(with: searchText) })
        } else {
            completion(self.cities)
        }
    }
    
    
}
