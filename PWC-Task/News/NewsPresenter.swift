//
//  NewsPresenter.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import Foundation

protocol NewsView: class {
    func startLoading()
    func finishLoading()
    func setSucceeded()
    func didGetError()
}

class NewsPresenter {
    
    weak var view: NewsView?
    private let newsService = NewsService(networking: Networking())
    
    private var newsModel: NewsModel?
    
    func attachView(_ view: NewsView) {
        self.view = view
    }
    
    func detachView(_ view: NewsView) {
        self.view = nil
    }
    
    func getNews(country: String) {
        view?.startLoading()
        let params = ["country": country]
        newsService.getNews(params: params) { [weak self] (model) in
            self?.newsModel = model
            self?.view?.finishLoading()
            self?.view?.setSucceeded()
        } failureHandler: { [weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.didGetError()
        }
    }
    
    func getNewsData() -> NewsModel? {
        return newsModel
    }
}
