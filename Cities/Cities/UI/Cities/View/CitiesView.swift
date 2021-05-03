//
//  CitiesView.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

protocol CitiesView: BaseViewController {
    func reloadTableView()
    func didUpdateSearchValue(_ value: String)
    func configureTableView()
    func configureSearchBar()
}
