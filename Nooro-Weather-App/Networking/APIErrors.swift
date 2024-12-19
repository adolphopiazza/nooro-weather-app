//
//  APIErrors.swift
//  Nooro-Weather-App
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/12/24.
//

import Foundation

enum APIErrors: Error {
    case errorOnAPI(httpCode: Int)
    case failedToDecode(error: DecodingError)
    case failedToFetch
}
