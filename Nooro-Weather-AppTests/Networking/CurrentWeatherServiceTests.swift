//
//  CurrentWeatherServiceTests.swift
//  Nooro-Weather-AppTests
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/12/24.
//

@testable import Nooro_Weather_App
import XCTest

final class CurrentWeatherServiceTests: XCTestCase {

    private var service: NetworkingService<CurrentWeatherModel>?
    
    func setQuery(city: String) {
        var url = URL.baseURL.appending(path: String.Endpoints.currentWeather)
        url = url.appending(queryItems: [.init(name: .Parameters.apiKey, value: .apiKey),
                                         .init(name: .Parameters.q, value: city)])
        
        service = NetworkingService<CurrentWeatherModel>(url: url)
    }
    
    func testFetchCurrentWeatherForBlumenau() async throws {
        setQuery(city: "Blumenau")
        
        let expectation = expectation(description: "FetchCurrentWeather")
        
        let data = try await service?.fetch()
        expectation.fulfill()
        
        await fulfillment(of: [expectation])
        
        // Data should not be nil
        XCTAssertNotNil(data)
        
        // Check if city is indeed Blumenau
        XCTAssertEqual(data?.location?.name, "Blumenau")
    }
    
    func testFetchCurrentWeatherForOrlando() async throws {
        setQuery(city: "Orlando")
        
        let expectation = expectation(description: "FetchCurrentWeather")
        
        let data = try await service?.fetch()
        expectation.fulfill()
        
        await fulfillment(of: [expectation])
        
        // Data should not be nil
        XCTAssertNotNil(data)
        
        // Check if city is indeed Orlando
        XCTAssertEqual(data?.location?.name, "Orlando")
    }
    
    func testFetchCurrentWeatherEmptyCity() async throws {
        setQuery(city: "")
        
        let expectation = expectation(description: "FetchCurrentWeather")
        var data: CurrentWeatherModel?
        var apiError: Error?
        
        do {
            data = try await service?.fetch()
        } catch {
            apiError = error
        }
        expectation.fulfill()
        
        await fulfillment(of: [expectation])
        
        // Data should be nil
        XCTAssertNil(data)
        
        // Error should not be nil
        XCTAssertNotNil(apiError)
    }

}
