//
//  WeatherInformationCardView.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

import SwiftUI

struct WeatherInformationCardView: View {
    
    @ObservedObject var viewModel: WeatherInformationCardViewModel
    
    var body: some View {
        HStack(spacing: 56) {
            VStack {
                Text("Humidity")
                    .foregroundStyle(.grayC4C4C4)
                    .font(.poppins(weight: .medium, size: 12))
                
                Text(viewModel.humidity)
                    .foregroundStyle(.gray9A9A9A)
                    .font(.poppins(weight: .medium, size: 15))
            }
            
            VStack {
                Text("UV")
                    .foregroundStyle(.grayC4C4C4)
                    .font(.poppins(weight: .medium, size: 12))
                
                Text(viewModel.uv)
                    .foregroundStyle(.gray9A9A9A)
                    .font(.poppins(weight: .medium, size: 15))
            }
            
            VStack {
                Text("Feels Like")
                    .foregroundStyle(.grayC4C4C4)
                    .font(.poppins(weight: .medium, size: 8))
                
                Text(viewModel.feelsLike)
                    .foregroundStyle(.gray9A9A9A)
                    .font(.poppins(weight: .medium, size: 15))
            }
        }
        .padding([.leading, .top, .bottom], 16)
        .padding(.trailing, 24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.grayF2F2F2)
        )
    }
    
}

#Preview {
    WeatherInformationCardView(viewModel: .init(weatherData: .init(celsiusTemperature: 24,
                                                                   condition: .init(icon: ""),
                                                                   humidity: 25,
                                                                   uv: 6,
                                                                   feelsLikeCelsiusTemperature: 25)))
}
