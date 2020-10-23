//
//  Endpoint.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 23/10/2020.
//

import Foundation

struct Configuration {
    static let apiKey = "e1992acc1ae946d1940a03bd7332df79"
    static let trackingURL = "https://api.covid19tracking.narrativa.com/api"
    static let newsURL = "https://newsapi.org/v2/top-headlines"
    static let countriesURL = "https://restcountries.eu/rest/v2/all"

}

enum Endpoint {
    case tracking
    case news
    case countries
    
    var path: String {
        switch self {
        case .tracking: return Configuration.trackingURL
        case .news: return Configuration.newsURL
        case .countries: return Configuration.countriesURL
        }
    }
}
