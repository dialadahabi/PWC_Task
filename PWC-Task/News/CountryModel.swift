//
//  CountryModel.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation

class CountriesList {
    
    static let shared = CountriesList()
    
    private init(){}
    
    var countries: [CountryModel]?

}

class CountryModel: Codable {
    
    var name: String
    var code: String
    var flag: String
    
    enum CodingKeys: String, CodingKey {
        case name, code = "alpha2Code", flag
    }
    
}
