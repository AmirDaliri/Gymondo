//
//  Exercises.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Foundation

// Represents a collection of exercises, often used for decoding JSON responses.
struct Exercises: Decodable, Equatable {
    
    // The total number of exercises available.
    let count: Int?
    // URL string pointing to the next set of results in a paginated API response.
    let next, previous: String?
    // An array of Exercise objects, representing individual exercises.
    let results: [Exercise]?
    
    // Custom initializer to create an Exercises object.
    // - Parameters:
    //   - count: The total number of exercises. Optional.
    //   - next: The URL string for the next page of results. Optional.
    //   - previous: The URL string for the previous page of results. Optional.
    //   - results: An array of Exercise objects. Optional.
    init(count: Int? = nil, next: String? = nil, previous: String? = nil, results: [Exercise]? = nil) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

// Extension to Exercises for custom equality comparison.
extension Exercises {
    // Custom equality operator to compare two Exercises objects.
    // - Parameters:
    //   - lhs: Left-hand side Exercises object for comparison.
    //   - rhs: Right-hand side Exercises object for comparison.
    // - Returns: Boolean indicating whether the two objects are equal.
    static func == (lhs: Exercises, rhs: Exercises) -> Bool {
        // Compares each property of the Exercises struct to determine equality.
        return lhs.count == rhs.count &&
        lhs.next == rhs.next &&
        lhs.previous == rhs.previous &&
        lhs.results == rhs.results
    }
}

extension Exercises {
    // Static function to create a mock Exercise instance.
    static func mock() -> Exercises {
        return Exercises(
            count: 3,
            next: "sample next",
            previous: "sample previous",
            results: [
                Exercise.mock(),
                Exercise.mock(),
                Exercise.mock()
            ]
        )
    }
}
