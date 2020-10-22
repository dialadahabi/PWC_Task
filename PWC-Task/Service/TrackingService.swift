//
//  TrackingService.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation
import Alamofire

struct TrackingService {
    
    let networking: Networking
    
    func getTrackingData(params: [String: Any], successHandler success: @escaping (TrackingWrapperModel) -> Void,
                      failureHandler failure: @escaping (Error?) -> Void) {
        
        networking.request(url: Endpoint.tracking.path, method: .get, parameters: params) { (data,error) in
            
            guard let data = data else {
                failure(error)
                return
            }
            if error != nil {
                failure(error)
                return
            }
            do {
                let countries = try JSONDecoder().decode(TrackingWrapperModel.self, from: data)
                success(countries)
            } catch {
                failure(error)
            }
            
        }
    }
}
