//
//  WeatherModel.swift
//  Beetroot
//
//  Created by Zubair Nurie on 2020-07-17
//

import Foundation

struct WeatherModel {
    let name: String
    let temp: Double
    let id: Int
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
