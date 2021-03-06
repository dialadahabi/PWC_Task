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
    func setEmptyView()
}

class NewsPresenter {
    
    weak var view: NewsView?
    private let newsService = NewsService(networking: Networking())
    
    private var newsWrapperModel: NewsWrapperModel?
    
    func attachView(_ view: NewsView) {
        self.view = view
    }
    
    func detachView(_ view: NewsView) {
        self.view = nil
    }
    
    func getNews(country: String) {
        view?.startLoading()
        let params = ["country": country, "category": "health", "apiKey": Configuration.apiKey]
        newsService.getNews(params: params) { [weak self] (model) in
            self?.newsWrapperModel = model
            if model.articles.isEmpty {
                self?.view?.setEmptyView()
            }
            self?.view?.finishLoading()
            self?.view?.setSucceeded()
        } failureHandler: { [weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.setEmptyView()
            self?.view?.didGetError()
        }
    }
    
    func getNewsData() -> [Article]? {
        return newsWrapperModel?.articles
    }
}
