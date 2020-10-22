//
//  TrackingMapModel.swift
//  PWC-Task
//
//  Created by Diala Dahabi on 22/10/2020.
//

import Foundation

class TrackingWrapperModel: Codable {
    
    var dates: TrackingDataWrapperModel
    var total: TrackingTotalModel
}

class TrackingDataWrapperModel: Codable {
    var datesArray: [TrackingCountriesModel]
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
        var tempArray = [TrackingCountriesModel]()
        for key in container.allKeys {
            let decodedObject = try container.decode(TrackingCountriesModel.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        datesArray = tempArray
    }
}

class TrackingTotalModel: Codable {
    
    var todayConfirmedCases: Int?
    var todayDeaths: Int?
    var todayNewConfirmedCases: Int?
    var todayNewDeaths: Int?
    
    enum CodingKeys: String, CodingKey {
        case todayConfirmedCases = "today_confirmed", todayDeaths = "today_deaths", todayNewConfirmedCases = "today_new_confirmed", todayNewDeaths = "today_new_deaths"
    }
}

class TrackingCountriesModel: Codable {
    var countries: [TrackingMapModel]
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
        var tempArray = [TrackingMapModel]()
        for key in container.allKeys {
            let decodedObject = try container.decode(TrackingMapModel.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        countries = tempArray
    }
}

class TrackingMapModel: Codable {
    
    var name: String?
    var todayConfirmedCases: Int?
    var todayDeaths: Int?
    var todayNewConfirmedCases: Int?
    var todayNewDeaths: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, todayConfirmedCases = "today_confirmed", todayDeaths = "today_deaths", todayNewConfirmedCases = "today_new_confirmed", todayNewDeaths = "today_new_deaths"
    }
}
