//
//  CurrentWeatherModel.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let location: CurrentWeatherLocationModel?
    let current: CurrentWeatherDataModel?
}

struct CurrentWeatherLocationModel: Decodable {
    let name: String?
}

struct CurrentWeatherDataModel: Decodable {
    let celsiusTemperature: Double?
    let condition: CurrentWeatherConditionModel?
    let humidity: Double?
    let uv: Double?
    let feelsLikeCelsiusTemperature: Double?
    
    enum CodingKeys: String, CodingKey {
        case celsiusTemperature = "temp_c"
        case condition
        case humidity
        case uv
        case feelsLikeCelsiusTemperature = "feelslike_c"
    }
}

struct CurrentWeatherConditionModel: Decodable {
    let icon: String?
}
