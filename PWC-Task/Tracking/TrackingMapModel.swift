//
//  TrackingMapModel.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation

class CountriesTrackingDataList {
    
    static let shared = CountriesTrackingDataList()
    
    private init(){}
    
    var countriesTrackingData: [Total]?

}

// MARK: - Welcome
struct TrackingWrapper: Codable {
    let dates: DatesWrapper
    let total: Total
    
    enum CodingKeys: String, CodingKey {
        case dates, total
    }
}

// MARK: - Dates
struct Dates: Codable {
    let countries: Countries
}

// MARK: - Countries
class Countries: Codable {
    var countriesList: [Total]
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = [Total]()
        for key in container.allKeys {
            let decodedObject = try container.decode(Total.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        countriesList = tempArray
    }
}

// MARK: - Total
struct Total: Codable {
    let name: String
    let todayConfirmed, todayDeaths, todayNewConfirmed, todayNewDeaths: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case todayConfirmed = "today_confirmed"
        case todayDeaths = "today_deaths"
        case todayNewConfirmed = "today_new_confirmed"
        case todayNewDeaths = "today_new_deaths"
    }
}

class DatesWrapper: Codable {
    var datesArray: [Dates]
    private struct DynamicCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = [Dates]()
        for key in container.allKeys {
            let decodedObject = try container.decode(Dates.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        datesArray = tempArray
    }
}
