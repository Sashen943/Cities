//
//  ViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class EntryViewController: BaseViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        let citiesViewController = CitiesViewController()
        citiesViewController.modalPresentationStyle = .overFullScreen
        self.show(citiesViewController, sender: self)
    }
    
}

