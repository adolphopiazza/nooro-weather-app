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
    
    func cleanUserDefaults() {
        UserDefaults.standard.removeObject(forKey: viewModel.userDefaultKey)
    }
    
    func testFetchCurrentWeatherForBlumenau() async throws {
        setUpViewModel()
        cleanUserDefaults()
        
        let expectation = expectation(description: "FetchCurrentWeather")
        await viewModel.fetchCurrentWeather(city: "Blumenau")
        expectation.fulfill()
        await fulfillment(of: [expectation])
        
        // Check if city is Blumenau
        XCTAssertEqual(viewModel.currentWeatherData?.location?.name, "Blumenau")
        
        // State should be hasData
        XCTAssertEqual(viewModel.state, .hasData)
    }
    
    func testFetchCurrentWeatherError() async throws {
        setUpViewModel()
        cleanUserDefaults()
        
        let expectation = expectation(description: "FetchCurrentWeatherError")
        await viewModel.fetchCurrentWeather(city: "")
        expectation.fulfill()
        await fulfillment(of: [expectation])
        
        // CurrentWeatherData should be nil
        XCTAssertNil(viewModel.currentWeatherData)
        
        // State should be error
        XCTAssertEqual(viewModel.state, .error)
    }
    
    func testSearchFetchCurrentWeatherState() async throws {
        setUpViewModel()
        cleanUserDefaults()
        
        let expectation = expectation(description: "SearchFetchCurrentWeatherState")
        await viewModel.fetchCurrentWeather(city: "Blumenau", isSearching: true)
        expectation.fulfill()
        await fulfillment(of: [expectation])
        
        // State should be .search
        XCTAssertEqual(viewModel.state, .search)
    }
    
    func testCityName() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.cityName, mockWeather.location?.name)
    }
    
    func testCityNameError() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.cityName, "N/A")
    }
    
    func testTemperature() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.temperature, mockWeather.current?.celsiusTemperature?.formatted())
    }
    
    func testTemperatureError() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.temperature, "N/A")
    }
    
    func testIcon() throws {
        setUpViewModel(with: mockWeather)
        
        XCTAssertEqual(viewModel.weatherIcon, "https://cdn.weatherapi.com/weather/64x64/night/113.png")
    }
    
    func testIconError() throws {
        setUpViewModel()
        
        XCTAssertEqual(viewModel.weatherIcon, "")
    }

}
