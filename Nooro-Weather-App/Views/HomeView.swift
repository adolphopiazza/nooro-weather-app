//
//  HomeView.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import SwiftUI

struct HomeView: View {
    
    private let currentWeatherService = CurrentWeatherService(endpoint: .Endpoints.currentWeather, querySearch: "Blumenau")
    
    var body: some View {
        Text("Hello, World!")
            .task {
                do {
                    let test = try await currentWeatherService.fetchCurrentWeather()
                    print(test)
                } catch {
                    print("error: \(error)")
                }
            }
    }
    
}

#Preview {
    HomeView()
}
