//
//  Weather.swift
//  Beetroot
//
//  Created by Zubair Nurie on 2020-07-15.
//

import Foundation

struct WeatherData: Codable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
}

struct Weather: Codable {
    var description: String
    var id: Int
}
