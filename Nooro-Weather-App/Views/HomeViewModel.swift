//
//  HomeViewModel.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import SwiftUI

@Observable
final class HomeViewModel {
    
    enum State {
        case idle
        case hasData
        case noData
        case search
        case error
    }
    
    private var weatherService: CurrentWeatherService?
    
    private(set) var currentWeatherData: CurrentWeatherModel?
    private(set) var isLoading: Bool = false
    
    var state: State = .idle
    let userDefaultKey: String = "currentWeatherCity"
    
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
        
        if let city = self.retrieveFromUserDefaults() {
            Task {
                await fetchCurrentWeather(city: city)
            }
        } else {
            self.state = .noData
        }
    }
    
    func fetchCurrentWeather(city: String, isSearching: Bool = false) async {
        defer {
            self.isLoading = false
        }
        
        weatherService = CurrentWeatherService(endpoint: .Endpoints.currentWeather, querySearch: city)
        
        do {
            self.isLoading = true
            self.currentWeatherData = try await weatherService?.fetchCurrentWeather()
            
            if isSearching {
                withAnimation {
                    self.state = .search
                }
                return
            }
            
            self.saveOnUserDefaults(city: city)
            self.state = .hasData
        } catch {
            print("Error on fetching current weather: \(error)")
            self.state = .error
        }
    }
    
    func saveOnUserDefaults(city: String) {
        UserDefaults.standard.set(city, forKey: self.userDefaultKey)
    }
    
    private func retrieveFromUserDefaults() -> String? {
        UserDefaults.standard.string(forKey: self.userDefaultKey)
    }
    
}
