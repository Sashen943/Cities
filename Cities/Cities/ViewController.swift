//
//  ViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = CityServiceImplementation()
        DispatchQueue.global(qos: .background).async {
            service.fetchCities { (result) in
                DispatchQueue.main.async {
                    print(result)
                }
            }
        }
    }


}

