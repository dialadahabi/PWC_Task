//
//  TrackingMapViewController.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import UIKit
import MapKit

class TrackingMapViewController: UIViewController {
    
    @IBOutlet weak var totalConfirmedCasesCountLabel: UILabel!
    @IBOutlet weak var todayConfirmedCasesCountLabel: UILabel!
    @IBOutlet weak var totalDeathsCountLabel: UILabel!
    @IBOutlet weak var todayDeathCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    private let presenter = TrackingMapPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        presenter.getTrackingData(startDate: formatter.string(from: Date()), endDate: formatter.string(from: Date()))
    }
    
}

extension TrackingMapViewController: TrackingMapView {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setSucceeded() {
        
    }
    
    func didGetError() {
        
    }
}
