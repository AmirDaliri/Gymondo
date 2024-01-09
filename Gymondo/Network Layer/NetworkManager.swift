//
//  NetworkManager.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Foundation
import Combine

// NetworkManager is responsible for managing network requests and data fetching.
class NetworkManager: NetworkServiceProtocol {
    
    // Fetches a list of exercises from the server.
    // - Returns: A publisher that emits an Exercises object or a NetworkError.
    func fetchExercises() -> AnyPublisher<Exercises, NetworkError> {
        let request = Router.fetchExercises.urlRequest

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                // Check for HTTP status code 200, otherwise decode the error response.
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: output.data)
                    throw errorResponse.toNetworkError()
                }
                return output.data
            }
            .mapError { error in
                // Convert any thrown errors to NetworkError.
                (error as? NetworkError) ?? NetworkError.underlyingError(error)
            }
            .flatMap(maxPublishers: .max(1)) { data in
                // Decode the data into an Exercises object.
                self.decode(data)
            }
            .eraseToAnyPublisher()
    }
    
    // Fetches details of a specific exercise by its ID.
    // - Parameter id: The ID of the exercise to fetch.
    // - Returns: A publisher that emits an Exercise object or a NetworkError.
    internal func fetchExercise(with id: Int) -> AnyPublisher<Exercise, NetworkError> {
        let request = Router.fetchExerciseDetails(id: id).urlRequest

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                // Check for HTTP status code 200, otherwise decode the error response.
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: output.data)
                    throw errorResponse.toNetworkError()
                }
                return output.data
            }
            .mapError { error in
                // Convert any thrown errors to NetworkError.
                (error as? NetworkError) ?? NetworkError.underlyingError(error)
            }
            .flatMap(maxPublishers: .max(1)) { data in
                // Decode the data into an Exercise object.
                self.decode(data)
            }
            .eraseToAnyPublisher()
    }

    // Fetches all variations of exercises based on given IDs with a delay between each fetch.
    // This method is useful when multiple network requests are made in sequence.
    // - Parameters:
    //   - variationIDs: An array of exercise IDs to fetch.
    //   - delaySeconds: Delay between each fetch request. This is used to prevent overwhelming the server with too many simultaneous requests and to comply with potential API rate limits. It also helps in managing client-side performance and providing a smoother user experience.
    // - Returns: A publisher that emits an array of Exercise objects or a NetworkError.
    func fetchAllVariations(variationIDs: [Int], delaySeconds: TimeInterval = 0.2) -> AnyPublisher<[Exercise], NetworkError> {
        let publishers = variationIDs.publisher
            .flatMap(maxPublishers: .max(1)) { id in
                // Fetch each exercise with a delay. The delay is introduced to space out the network requests, reducing the load on both the server and client, and to manage the overall network performance more effectively.
                self.fetchExercise(with: id)
                    .delay(for: .seconds(delaySeconds), scheduler: DispatchQueue.main)
            }
            .collect() // Collect all fetched exercises into an array.
            .eraseToAnyPublisher()

        return publishers
    }


    // Generic helper function for decoding a JSON response into a specified Decodable type.
    // - Parameter data: The data to decode.
    // - Returns: A publisher that emits a decoded object or a NetworkError.
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
        Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { NetworkError.decodingError($0) }
            .eraseToAnyPublisher()
    }
}
