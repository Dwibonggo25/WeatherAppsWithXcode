//
//  WeatherModel.swift
//  Weather
//
//  Created by Dwi Bonggo Pribadi on 12/12/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperatur: Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperatur)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud_rain"
        default:
            return "cloud"
        }
    }
}
