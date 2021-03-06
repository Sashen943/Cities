//
//  CitiesView.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

protocol CitiesView: BaseViewController {
    func reloadTableView()
    func navigateToCityScreen()
    func configureTableView()
    func configureSearchBar(_ placeholder: String)
}
