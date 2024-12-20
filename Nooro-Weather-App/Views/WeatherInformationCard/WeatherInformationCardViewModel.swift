//
//  WeatherInformationCardViewModel.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import SwiftUI

final class WeatherInformationCardViewModel: ObservableObject {
    
    @Published var weatherData: CurrentWeatherDataModel?
    
    var humidity: String {
        guard let humidity = weatherData?.humidity else {
            return "N/A"
        }
        
        return "\(humidity.formatted())%"
    }
    
    var uv: String {
        guard let uv = weatherData?.uv else {
            return "N/A"
        }
        
        return uv.formatted()
    }
    
    var feelsLike: String {
        guard let feelsLike = weatherData?.feelsLikeCelsiusTemperature else {
            return "N/A"
        }
        
        return "\(feelsLike.formatted())°"
    }
    
    init(weatherData: CurrentWeatherDataModel?) {
        self.weatherData = weatherData
    }
    
}
