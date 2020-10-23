//
//  TrackingMapPresenter.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation

protocol TrackingMapView: class {
    func startLoading()
    func finishLoading()
    func setSucceeded()
    func didGetError()
    func setEmptyView()
}

class TrackingMapPresenter {
    
    weak var view: TrackingMapView?
    private let trackingService = TrackingService(networking: Networking())
    private let countriesService = CountriesService(networking: Networking())
    
    private var trackingWrapperModel: TrackingWrapper?
    
    func attachView(_ view: TrackingMapView) {
        self.view = view
    }
    
    func detachView(_ view: TrackingMapView) {
        self.view = nil
    }
    
    func getTrackingData(startDate: String, endDate: String) {
        view?.startLoading()
        let params = ["date_from": startDate, "date_to": endDate]
        trackingService.getTrackingData(params: params) { [weak self] (model) in
            self?.trackingWrapperModel = model
            CountriesTrackingDataList.shared.countriesTrackingData = model.dates.datesArray.first?.countries.countriesList
            if model.dates.datesArray.isEmpty {
                self?.view?.setEmptyView()
            }
            self?.view?.finishLoading()
            self?.view?.setSucceeded()
        } failureHandler: { [weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.didGetError()
        }
    }
    
    func getTrackingData() -> TrackingWrapper? {
        return trackingWrapperModel
    }
    
    func getCountries() {
        countriesService.getCountries { (model) in
            CountriesList.shared.countries = model
        } failureHandler: { [weak self] (error) in
            self?.view?.didGetError()
        }
    }
}
