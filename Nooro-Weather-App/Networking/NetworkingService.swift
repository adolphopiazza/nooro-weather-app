//
//  NetworkingService.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import Foundation

protocol NetworkingServiceProtocol {
    associatedtype T
    
    func fetch() async throws -> T
}

final class NetworkingService<T: Decodable>: NetworkingServiceProtocol {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch() async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: self.url)
            
            if let httpCode = response as? HTTPURLResponse, httpCode.statusCode != 200 {
                throw APIErrors.errorOnAPI(httpCode: httpCode.statusCode)
            }
            
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch let error as DecodingError {
            throw APIErrors.failedToDecode(error: error)
        } catch {
            throw error
        }
    }
    
}
