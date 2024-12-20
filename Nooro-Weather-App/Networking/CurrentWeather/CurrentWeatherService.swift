//
//  CurrentWeatherService.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import Foundation

protocol CurrentWeatherProtocol {
    func fetchCurrentWeather() async throws -> CurrentWeatherModel
}

final class CurrentWeatherService: CurrentWeatherProtocol {
    
    private let endpoint: String
    private let querySearch: String
    
    private var service: NetworkingService<CurrentWeatherModel>?
    
    init(endpoint: String, querySearch: String) {
        self.endpoint = endpoint
        self.querySearch = querySearch
    }
    
    func fetchCurrentWeather() async throws -> CurrentWeatherModel {
        var url = URL.baseURL.appending(path: self.endpoint)
        url = url.appending(queryItems: [.init(name: .Parameters.apiKey, value: .apiKey),
                                         .init(name: .Parameters.q, value: self.querySearch)])
        url.removeAllCachedResourceValues()
        
        service = .init(url: url)
        
        do {
            guard let data = try await service?.fetch() else {
                throw APIErrors.failedToFetch
            }
            
            return data
        } catch {
            throw error
        }
    }
    
}
