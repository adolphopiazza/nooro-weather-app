//
//  HomeViewModelTests.swift
//  Nooro-Weather-AppTests
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

@testable import Nooro_Weather_App
import XCTest

final class HomeViewModelTests: XCTestCase {

    let mockWeather = CurrentWeatherModel(location: .init(name: "Rome"),
                                          current: .init(celsiusTemperature: 31.2,
                                                         condition: .init(icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"),
                                                         humidity: 29,
                                                         uv: 4,
                                                         feelsLikeCelsiusTemperature: 34.2))
    
    var viewModel: HomeViewModel!
    
    func setUpViewModel(with model: CurrentWeatherModel? = nil) {
        viewModel = HomeViewModel(weatherData: model)
    }
    
    func testFetchCurrentWeatherForBlumenau() async throws {
        setUpViewModel()
        
        let expectation = expectation(description: "FetchCurrentWeather")
        await viewModel.fetchCurrentWeather(city: "Blumenau")
        expectation.fulfill()
        await fulfillment(of: [expectation])
        
        // Check if city is Blumenau
        XCTAssertEqual(viewModel.currentWeatherData?.location?.name, "Blumenau")
    }
    
    func testFetchCurrentWeatherError() async throws {
        setUpViewModel()
        
        let expectation = expectation(description: "FetchCurrentWeatherError")
        await viewModel.fetchCurrentWeather(city: "")
        expectation.fulfill()
        await fulfillment(of: [expectation])
        
        // CurrentWeatherData should be nil
        XCTAssertNil(viewModel.currentWeatherData)
    }
    
    func testCityName() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.cityName, mockWeather.location?.name)
    }
    
    func testTemperature() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.temperature, mockWeather.current?.celsiusTemperature?.formatted())
    }
    
    func testIcon() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.weatherIcon, "https://cdn.weatherapi.com/weather/64x64/night/113.png")
    }

}
