//
//  TrackingMapViewController.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import UIKit
import MapKit

class TrackingMapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var totalConfirmedCasesCountLabel: UILabel!
    @IBOutlet weak var todayConfirmedCasesCountLabel: UILabel!
    @IBOutlet weak var totalDeathsCountLabel: UILabel!
    @IBOutlet weak var todayDeathCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    private let presenter = TrackingMapPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.getTrackingData(startDate: formatDate(date: Date()), endDate: formatDate(date: Date()))
        presenter.getCountries()
        configureMapView()
    }
    
    private func configureMapView() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] (result, error) in
            let newsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            newsVC.countryName = result?.first?.country
            self?.navigationController?.pushViewController(newsVC, animated: true)
        }
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
}

extension TrackingMapViewController: TrackingMapView {
    func startLoading() {
        view.showLoader()
    }
    
    func finishLoading() {
        view.dismissLoader()
    }
    
    func setSucceeded() {
        let trackingModel = presenter.getTrackingData()
        totalConfirmedCasesCountLabel.text = String(trackingModel?.total.todayConfirmedCases ?? 0)
        todayConfirmedCasesCountLabel.text = String(trackingModel?.total.todayNewConfirmedCases ?? 0)
        totalDeathsCountLabel.text = String(trackingModel?.total.todayDeaths ?? 0)
        todayDeathCountLabel.text = String(trackingModel?.total.todayNewDeaths ?? 0)
    }
    
    func didGetError() {
        emptyView.isHidden = false
    }
}
