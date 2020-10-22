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
}

class TrackingMapPresenter {
    
    weak var view: TrackingMapView?
    private let trackingService = TrackingService(networking: Networking())
    
    private var trackingWrapperModel: TrackingWrapperModel?
    
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
            self?.view?.finishLoading()
            self?.view?.setSucceeded()
        } failureHandler: { [weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.didGetError()
        }
    }
    
    func getTrackingData() -> TrackingWrapperModel? {
        return trackingWrapperModel
    }
}
