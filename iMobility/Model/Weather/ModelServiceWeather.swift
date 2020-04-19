//
//  ModelServiceWeather.swift
//  iMobility
//
//  Created by Osama Fawzi on 19.04.20.
//  Copyright © 2020 Osama Fawzi. All rights reserved.
//

import Foundation

typealias  Weather = Model.Service.Weather

extension Model.Service {
    
    struct Weather: Codable {
        
        let coord: Coordinate
        let weather: [Details]
        let base: String
        let main: Main
        let wind: Wind
        let clouds: Clouds
        let dt: Int
        let sys: Sys
        let id: Int
        let name: String
        let cod: Int
        
    }
    
    struct Clouds: Codable {
        let all: Int
    }

    struct Main: Codable {
        let temp: Double
        let pressure, humidity: Int
        let tempMin, tempMax: Double

        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }

    struct Sys: Codable {
        let type, id: Int?
        let message: Double?
        let country: String
        let sunrise, sunset: Int
    }

    struct Details: Codable {
        let id: Int
        let main, weatherDescription, icon: String

        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }

    
}
