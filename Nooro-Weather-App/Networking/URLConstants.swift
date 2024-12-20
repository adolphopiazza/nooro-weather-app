//
//  URLConstants.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import Foundation

extension URL {
    static let baseURL = URL(string: "https://api.weatherapi.com/v1")!
}

extension String {
    
    // API Key from WeatherAPI
    // It's here only for the Home Test
    // Will be revoked on 01/01/2025
    static let apiKey = "c72cff0f898342df93e204606241812"
    
    struct Endpoints {
        static let currentWeather = "current.json"
    }
    
    struct Parameters {
        static let q = "q"
        static let apiKey = "key"
    }
    
}
