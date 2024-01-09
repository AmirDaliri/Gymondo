//
//  NetworkServiceProtocol.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Combine
import Foundation

// Protocol defining the requirements for a network service in the application.
// This protocol ensures that any network service class conforms to a standard interface for fetching exercise data.
protocol NetworkServiceProtocol {
    // Function to fetch a list of exercises.
    // - Returns: A publisher that emits an Exercises object (containing multiple Exercise instances) or a NetworkError. The use of AnyPublisher allows for flexibility in the underlying implementation, making the protocol adaptable to different networking strategies.
    func fetchExercises() -> AnyPublisher<Exercises, NetworkError>

    // Function to fetch details of a specific exercise identified by its ID.
    // - Parameter id: The unique identifier of the exercise to fetch.
    // - Returns: A publisher that emits a single Exercise object or a NetworkError. This method is crucial for retrieving detailed information about a specific exercise, such as its description, images, and variations.
    /*func fetchExercise(with id: Int) -> AnyPublisher<Exercise, NetworkError>*/
    
    // This method fetches all exercise variations based on their IDs, with an optional delay between each fetch.
    // - Parameters:
    //   - variationIDs: An array of Integers representing the IDs of the exercise variations to fetch.
    //   - delaySeconds: Optional delay in seconds between each fetch request. Defaults to 0.2 seconds.
    // - Returns: A publisher that emits an array of Exercise objects or a NetworkError.
    func fetchAllVariations(variationIDs: [Int], delaySeconds: TimeInterval) -> AnyPublisher<[Exercise], NetworkError>

}
