//
//  HomeView.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            SearchBarView { query in
                Task {
                    await viewModel.fetchCurrentWeather(city: query)
                }
            }
            .padding(.top, 44)
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 0) {
                currentWeatherView
                
                WeatherInformationCardView(viewModel: .init(weatherData: viewModel.informationWeather))
                    .padding(.top, 36)
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                }
            }
        }
        .padding(.horizontal, 24)
        .ignoresSafeArea(.keyboard)
    }
    
    private var currentWeatherView: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: viewModel.weatherIcon)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "x.square")
                        .resizable()
                }
            }
            .frame(width: 123, height: 113)
            
            HStack(spacing: 12) {
                Text(viewModel.cityName)
                    .font(.poppins(weight: .semiBold, size: 30))
                
                Image(systemName: "location.fill")
                    .frame(width: 21, height: 21)
            }
            .foregroundStyle(.black2C2C2C)
            .padding(.top, 24)
            
            HStack(alignment: .top, spacing: 2) {
                Text(viewModel.temperature)
                    .font(.poppins(weight: .medium, size: 70))
                
                Text("°")
                    .font(.system(size: 24))
                    .offset(y: 10)
            }
            .foregroundStyle(.black2C2C2C)
            .padding(.top, 24)
        }
    }
    
}

#Preview {
    HomeView()
}
