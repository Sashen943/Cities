//
//  CitiesViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class CitiesViewController: BaseViewController {
    
    // MARK: Dependencies
    
    private lazy var viewModel = CitiesViewModel(view: self,
                                                 repository: CitiesRepositoryImplementation())
    
    // MARK: IBOutlet(s)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.configureUI()
        self.viewModel.fetchCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
}

// MARK: CitiesView Extension

extension CitiesViewController: CitiesView {
    
    func reloadTableView() {
        self.citiesTableView.reloadData()
    }
    
    func navigateToCityScreen() {
        let cityViewController = CityViewController()
        self.navigate(to: cityViewController)
    }
    
    func configureTableView() {
        self.citiesTableView.delegate = self
        self.citiesTableView.dataSource = self
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        self.citiesTableView.register(nib,
                                      forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    func configureSearchBar(_ placeholder: String) {
        self.searchBar.placeholder = "Search a city"
        self.searchBar.delegate = self
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource Extension

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier,
                                                    for: indexPath) as? CityTableViewCell {
            let city = viewModel.filteredCities[indexPath.row]
            let title = "\(city.name), \(city.country)"
            let subtitle = "lat: \(city.coord.lat) long: \(city.coord.lon)"
            cell.configureCell(title: title, subtitle: subtitle)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCity(at: indexPath.row)
    }
    
}

// MARK: UISearchBarDelegate Extension

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text
        self.viewModel.filterCities(text)
    }
    
}
