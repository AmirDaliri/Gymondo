//
//  MockNetworkService.swift
//  GymondoTests
//
//  Created by Amir Daliri on 6.01.2024.
//

import Combine
import Foundation
@testable import Gymondo

/**
 A mock implementation of the `NetworkServiceProtocol` for testing purposes.

 This class provides a mock network service that can be used for testing network-related functionality in the application. It allows you to simulate different network responses and errors to ensure proper handling by other components.

 ## Usage Example:
 ```swift
 // Create an instance of the `MockNetworkService` with custom result values.
 let mockService = MockNetworkService(
     exercisesResult: .success(Exercises(results: [])),
     exerciseResult: .success(Exercise()),
     variationsResult: .success([]),
     errorResponse: nil
 )

 // Use the `mockService` for testing network-related functionality.
 */
class MockNetworkService: NetworkServiceProtocol {
    // Properties to customize the mock responses
    var exercisesResult: Result<Exercises, NetworkError>
    var exerciseResult: Result<Exercise, NetworkError>
    var variationsResult: Result<[Exercise], NetworkError>
    var errorResponse: ErrorResponse?
    
    /**
     Initializes the `MockNetworkService` with custom result values.

     - Parameters:
        - exercisesResult: The result for fetching exercises.
        - exerciseResult: The result for fetching a single exercise.
        - variationsResult: The result for fetching exercise variations.
        - errorResponse: An optional error response to simulate network errors.
     */
    init(
        exercisesResult: Result<Exercises, NetworkError> = .success(Exercises()),
        exerciseResult: Result<Exercise, NetworkError> = .success(Exercise()),
        variationsResult: Result<[Exercise], NetworkError> = .success([]),
        errorResponse: ErrorResponse? = nil
    ) {
        self.exercisesResult = exercisesResult
        self.exerciseResult = exerciseResult
        self.variationsResult = variationsResult
        self.errorResponse = errorResponse
    }

    /**
     Simulates fetching a list of exercises.

     - Returns: A publisher that emits the result of fetching exercises.
     */
    func fetchExercises() -> AnyPublisher<Exercises, NetworkError> {
        // Implementation simulating the network request and response.
        return Future<Exercises, NetworkError> { promise in
            if let errorResponse = self.errorResponse {
                promise(.failure(errorResponse.toNetworkError()))
            } else {
                switch self.exercisesResult {
                case .success(let exercises):
                    promise(.success(exercises))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /**
     Simulates fetching a single exercise by ID.

     - Parameter id: The ID of the exercise to fetch.
     - Returns: A publisher that emits the result of fetching the exercise.
     */
    func fetchExercise(with id: Int) -> AnyPublisher<Exercise, NetworkError> {
        // Implementation simulating the network request and response.
        return Future<Exercise, NetworkError> { promise in
            if let errorResponse = self.errorResponse {
                promise(.failure(errorResponse.toNetworkError()))
            } else {
                switch self.exerciseResult {
                case .success(let exercise):
                    promise(.success(exercise))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    /**
     Simulates fetching all variations of an exercise.

     - Parameters:
        - variationIDs: An array of variation IDs to fetch.
        - delaySeconds: An optional delay to simulate network latency.
     - Returns: A publisher that emits the result of fetching exercise variations.
     */
    func fetchAllVariations(variationIDs: [Int], delaySeconds: TimeInterval = 0.2) -> AnyPublisher<[Exercise], NetworkError> {
        // Implementation simulating the network request and response.
        return Future<[Exercise], NetworkError> { promise in
            if let errorResponse = self.errorResponse {
                promise(.failure(errorResponse.toNetworkError()))
            } else {
                switch self.variationsResult {
                case .success(let variations):
                    promise(.success(variations))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
