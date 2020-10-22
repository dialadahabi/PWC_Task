//
//  Networking.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation
import Alamofire

protocol Networkable {
    typealias NetworkingCompletionHandler = (Data?, Error?) -> Void

    func request(url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 paramEncoding: ParameterEncoding?,
                 responseCompletition: @escaping NetworkingCompletionHandler)
}

class Networking: Networkable {
    
    private var session: Alamofire.Session?

    init() {

        session = Alamofire.Session(configuration: configureSession())
    }

    private final func configureSession() -> URLSessionConfiguration {
        let sessionConfiguration: URLSessionConfiguration
            sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.allowsConstrainedNetworkAccess = true
            sessionConfiguration.requestCachePolicy = .reloadRevalidatingCacheData//check later
            sessionConfiguration.timeoutIntervalForRequest = 15

        return sessionConfiguration
    }
    
    func request(url: URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters? = nil,
                 paramEncoding: ParameterEncoding? = nil,
                 responseCompletition: @escaping NetworkingCompletionHandler) {

        let request = session?.request(url, method: method, parameters: parameters,
                                       encoding: paramEncoding ?? JSONEncoding.default)
        request?.response(completionHandler: { (dataResponse) in

            responseCompletition(dataResponse.data,
                                 dataResponse.error)

        }).validate(statusCode: 200...299)

    }
    
}

enum Endpoint {
    case tracking
    case news
    case countries
    
    var path: String {
        switch self {
        case .tracking: return "https://api.covid19tracking.narrativa.com/api"
        case .news: return "https://newsapi.org/v2/top-headlines"
        case .countries: return "https://restcountries.eu/rest/v2/all"
        }
    }
}
