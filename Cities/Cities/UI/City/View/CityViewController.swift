//
//  CityViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/04.
//

import UIKit
import CoreLocation
import MapKit

class CityViewController: BaseViewController {
    
    // MARK: IBOutelt(s)
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Dependencies
    
    private lazy var viewModel = CityViewModel(CityRepositoryImplementation(),
                                               self)
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.configureUI()
        self.viewModel.fetchCity()
    }



}

extension CityViewController: CityView {
    func configureMap(_ location: CLLocation, _ name: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = name
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 1000,
                                                  longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
}
