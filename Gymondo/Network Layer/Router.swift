//
//  Router.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Foundation

// Enum representing the various network endpoints used within the Gymondo app.
// It conforms to the Endpoint protocol and provides a structured way to manage URL construction for different network requests.
enum Router: Endpoint {
    // Enum cases for each type of network request.
    case fetchExercises // Case for fetching a list of exercises.
    case fetchExerciseDetails(id: Int) // Case for fetching details of a specific exercise, identified by its ID.

    // Base URL for the network requests.
    // It's defined as a computed property that returns the URL object for the base address of the network service.
    var baseUrl: URL {
        return URL(string: "https://wger.de/api/v2")!
    }

    // Path for the specific endpoint.
    // It's determined based on the enum case and is appended to the base URL to form the full URL for a request.
    var path: String {
        switch self {
        case .fetchExercises:
            // Path for fetching a list of exercises.
            return "/exerciseinfo"
        case .fetchExerciseDetails(id: let id):
            // Path for fetching exercise details, with the exercise ID embedded in the URL.
            return "/exerciseinfo/\(id)"
        }
    }

    // URLRequest construction for the specific network request.
    // This computed property constructs and returns a URLRequest object for the given endpoint, combining the base URL with the specific path.
    var urlRequest: URLRequest {
        // Create the full URL by appending the path to the base URL.
        let url = baseUrl.appendingPathComponent(path)
        // Return a URLRequest object initialized with the URL.
        return URLRequest(url: url)
    }
}

