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
                    await viewModel.fetchCurrentWeather(city: query, isSearching: true)
                }
            }
            .padding(.top, 44)
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 0) {
                switch viewModel.state {
                case .idle:
                    EmptyView() // Should not enter here
                case .hasData:
                    currentWeatherView
                    
                    WeatherInformationCardView(viewModel: .init(weatherData: viewModel.informationWeather))
                        .padding(.top, 36)
                case .noData:
                    noDataView
                case .search:
                    searchView
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 122)
                        .onTapGesture {
                            withAnimation {
                                viewModel.state = .hasData
                                viewModel.saveOnUserDefaults(city: viewModel.cityName)
                            }
                        }
                case .error:
                    Text("We got an error 😞\nPlease try a new search")
                        .foregroundStyle(.black2C2C2C)
                        .font(.poppins(weight: .medium, size: 20))
                        .multilineTextAlignment(.center)
                }
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
                } else if phase.error != nil {
                    Image(systemName: "x.square")
                        .resizable()
                } else {
                    ProgressView()
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
    
    private var noDataView: some View {
        Group {
            Text("No City Selected")
                .foregroundStyle(.black2C2C2C)
                .font(.poppins(weight: .semiBold, size: 30))
            
            Text("Please Search For A City")
                .foregroundStyle(.black2C2C2C)
                .font(.poppins(weight: .semiBold, size: 15))
                .padding(.top, 10)
        }
    }
    
    private var searchView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.cityName)
                    .font(.poppins(weight: .semiBold, size: 20))
                
                HStack(alignment: .top, spacing: 2) {
                    Text(viewModel.temperature)
                        .font(.poppins(weight: .medium, size: 60))
                    
                    Text("°")
                        .font(.system(size: 24))
                        .offset(y: 10)
                }
            }
            .foregroundStyle(.black2C2C2C)
            
            Spacer()
            
            AsyncImage(url: URL(string: viewModel.weatherIcon)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Image(systemName: "x.square")
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 83, height: 67)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 31)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.grayF2F2F2)
        )
    }
    
}

#Preview {
    HomeView()
}
