//
//  WeatherData.swift
//  Weather
//
//  Created by Dwi Bonggo Pribadi on 12/12/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp : Double
}

struct Weather: Decodable {
    let id : Int
    
    let description: String
}
