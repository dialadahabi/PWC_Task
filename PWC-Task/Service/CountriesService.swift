//
//  CountriesService.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation
import Alamofire

struct CountriesService {
    
    let networking: Networking
    
    func getCountries(params: [String: Any], successHandler success: @escaping (CountryModel) -> Void,
                      failureHandler failure: @escaping (Error?) -> Void) {
        
        networking.request(url: Endpoint.countries.path, method: .get, parameters: params, paramEncoding: URLEncoding.default) { (data,error) in
            
            guard let data = data else {
                failure(error)
                return
            }
            if error != nil {
                failure(error)
                return
            }
            do {
                let countries = try JSONDecoder().decode(CountryModel.self, from: data)
                success(countries)
            } catch {
                failure(error)
            }
            
        }
    }
}
