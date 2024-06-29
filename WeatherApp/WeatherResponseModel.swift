//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Laxmi Chandrashekhar Chatla on 29/06/24.
//

import Foundation
struct WeatherResponse: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

struct Current: Codable {
    let temp_c: Double
    let is_day: Int
    let condition: Condition
    let wind_kph: Double
    let wind_degree: Int
    let wind_dir,last_updated: String
    let pressure_mb: Double
    let humidity: Int
    let cloud: Int
    let feelslike_c: Double
    let vis_km: Double
    let temp_f: Double
    let uv: Double
    let gust_kph: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
