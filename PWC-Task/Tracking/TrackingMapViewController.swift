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
    @IBOutlet weak var countryTodayDeathCountLabel: UILabel!
    @IBOutlet weak var countryTodayConfirmedCasesCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryDetailsView: UIView!
    
    private var center: CLLocationCoordinate2D?
    private var geocoder = CLGeocoder()
    
    private let presenter = TrackingMapPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.getTrackingData(startDate: Date().toString(), endDate: Date().toString())
        presenter.getCountries()
        configureMapView()
    }
    
    private func configureMapView() {
        mapView.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func configureCountryDetailsView() {
        coordinateToName(location: CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude)) { [weak self](result, error) in
            if var country = result?.first?.country {
                self?.getCountryTrackingDetails(countryName: &country)
            }
        }
    }
    
    private func getCountryTrackingDetails(countryName: inout String) {
        if countryName == "United States" {countryName = "US"}
        let countryData = CountriesTrackingDataList.shared.countriesTrackingData?.filter({$0.name == countryName}).first
        countryTodayConfirmedCasesCountLabel.text = String(countryData?.todayConfirmed ?? 0)
        countryTodayDeathCountLabel.text = String(countryData?.todayDeaths ?? 0)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        coordinateToName(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) {[weak self] (result, error) in
            let newsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            newsVC.countryName = result?.first?.country
            self?.navigationController?.pushViewController(newsVC, animated: true)
        }
    }
    
    private func coordinateToName(location: CLLocation, completion: @escaping CLGeocodeCompletionHandler) {
        geocoder.reverseGeocodeLocation(location, completionHandler: completion)
    }
    
}

extension TrackingMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        coordinateToName(location: location) { [weak self] (result, error) in
            self?.countryDetailsView.isHidden = result?.first?.country == nil
            if var country = result?.first?.country {
                self?.getCountryTrackingDetails(countryName: &country)
                self?.countryNameLabel.text = country
            }
        }
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
        configureCountryDetailsView()
        let trackingModel = presenter.getTrackingData()
        totalConfirmedCasesCountLabel.text = String(trackingModel?.total.todayConfirmed ?? 0)
        todayConfirmedCasesCountLabel.text = String(trackingModel?.total.todayNewConfirmed ?? 0)
        totalDeathsCountLabel.text = String(trackingModel?.total.todayDeaths ?? 0)
        todayDeathCountLabel.text = String(trackingModel?.total.todayNewDeaths ?? 0)
    }
    
    func didGetError() {
        emptyView.isHidden = false
        self.showError(title: "Error", message: "Something went wrong, please try again.")
    }
    
    func setEmptyView() {
        emptyView.isHidden = false
    }
}
