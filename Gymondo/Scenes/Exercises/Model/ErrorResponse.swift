//
//  ErrorResponse.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Foundation

struct ErrorResponse: Codable, Error {
    let detail: String
}

extension ErrorResponse {
    func toNetworkError() -> NetworkError {
        // Here, you can decide how to map the 'detail' string to a specific NetworkError.
        // For example, if the detail is "Not found", you might want to map it to .notFound
        if detail == "Not found." {
            return .notFound // Assuming you have a .notFound case in NetworkError
        } else {
            // For any other error, you might want to use a generic error case.
            return .otherError(detail)
        }
    }
}

