//
//  ViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class EntryViewController: BaseViewController {
    
    // MARK: IBAction(s)
    
    @IBAction func loadCitiesButtonTapped(_ sender: UIButton) {
        self.navigateToCitiesViewController()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Method(s)
    
    private func navigateToCitiesViewController() {
        let citiesViewController = CitiesViewController()
        self.navigate(to: citiesViewController)
    }
    
}

