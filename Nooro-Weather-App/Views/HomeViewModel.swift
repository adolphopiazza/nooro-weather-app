//
//  HomeViewModel.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import Foundation

@Observable
final class HomeViewModel {
    
    private var weatherService: CurrentWeatherService?
    
    private(set) var currentWeatherData: CurrentWeatherModel?
    private(set) var isLoading: Bool = false
    
    var cityName: String {
        guard let city = currentWeatherData?.location?.name else {
            return "N/A"
        }
        
        return city
    }
    
    var temperature: String {
        guard let temperature = currentWeatherData?.current?.celsiusTemperature else {
            return "N/A"
        }
        
        return temperature.formatted()
    }
    
    var weatherIcon: String {
        guard let icon = currentWeatherData?.current?.condition?.icon else {
            return ""
        }
        
        return "https:\(icon)"
    }
    
    var informationWeather: CurrentWeatherDataModel? {
        return currentWeatherData?.current
    }
    
    init(weatherData: CurrentWeatherModel? = nil) {
        self.currentWeatherData = weatherData
        // Check in userDefaults for saved queries - do later
    }
    
    func fetchCurrentWeather(city: String) async {
        defer {
            self.isLoading = false
        }
        
        weatherService = CurrentWeatherService(endpoint: .Endpoints.currentWeather, querySearch: city)
        
        do {
            self.isLoading = true
            self.currentWeatherData = try await weatherService?.fetchCurrentWeather()
        } catch {
            print("Error on fetching current weather: \(error)")
        }
    }
    
}
