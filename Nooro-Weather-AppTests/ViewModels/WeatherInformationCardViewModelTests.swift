//
//  WeatherInformationCardViewModelTests.swift
//  Nooro-Weather-AppTests
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

@testable import Nooro_Weather_App
import XCTest

final class WeatherInformationCardViewModelTests: XCTestCase {

    let mockWeather = CurrentWeatherDataModel(celsiusTemperature: 21.1,
                                              condition: .init(icon: nil),
                                              humidity: 39,
                                              uv: 3,
                                              feelsLikeCelsiusTemperature: 22.7)
    
    var viewModel: WeatherInformationCardViewModel!
    
    func setUpViewModel() {
        viewModel = WeatherInformationCardViewModel(weatherData: mockWeather)
    }
    
    func testHumidity() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.humidity, "\(mockWeather.humidity?.formatted() ?? "N/A")%")
    }
    
    func testUv() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.uv, mockWeather.uv?.formatted())
    }
    
    func testFeelsLike() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.feelsLike, "\(mockWeather.feelsLikeCelsiusTemperature?.formatted() ?? "N/A")°")
    }

}
