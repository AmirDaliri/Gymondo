//
//  Exercise.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import Foundation
import Kingfisher

// Struct representing a single exercise, conforming to Decodable for JSON parsing.
struct Exercise: Decodable {
    // Properties representing various attributes of an exercise.
    let id: Int?
    let name: String?
    let uuid: String?
    let exerciseBaseID: Int?
    let description: String?
    let created: String?
    // An array of ExerciseImage objects, representing images associated with the exercise.
    let images: [ExerciseImage]?
    // An array of Integers representing variations of the exercise.
    let variations: [Int]?
    
    // Custom initializer to create an Exercise instance.
    // Parameters are optional to allow flexibility in initialization.
    init(id: Int? = nil, name: String? = nil, uuid: String? = nil, exerciseBaseID: Int? = nil, description: String? = nil, created: String? = nil, category: Category? = nil, images: [ExerciseImage]? = nil, variations: [Int]? = nil) {
        self.id = id
        self.name = name
        self.uuid = uuid
        self.exerciseBaseID = exerciseBaseID
        self.description = description
        self.created = created
        self.images = images
        self.variations = variations
    }
    
    // Custom coding keys for decoding the JSON, handling cases where JSON keys and struct property names differ.
    enum CodingKeys: String, CodingKey {
        case id, name, uuid
        case exerciseBaseID = "exercise_base_id"
        case description, created
        case images, variations
    }
    
    // Function to get the URL string of the main image associated with the exercise.
    // - Returns: The URL string of the main image, if available.
    func getMainImageUrlString() -> String? {
        images?.first(where: { $0.isMain == true })?.image
    }
    
    // Function to get the URL of the main image associated with the exercise.
    // - Returns: A URL object of the main image, if available.
    func getMainImageUrl() -> URL? {
        URL.init(string: images?.first(where: { $0.isMain == true })?.image ?? "")
    }
}

// Extension to Exercise for custom equality comparison.
extension Exercise: Equatable {
    // Custom equality operator to compare two Exercise objects.
    // Compares all properties to determine if two Exercise instances are equal.
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.uuid == rhs.uuid &&
        lhs.exerciseBaseID == rhs.exerciseBaseID &&
        lhs.description == rhs.description &&
        lhs.created == rhs.created &&
        lhs.images == rhs.images &&
        lhs.variations == rhs.variations
    }
}

extension Exercise {
    // Static function to create a mock Exercise instance.
    static func mock() -> Exercise {
        return Exercise(
            id: 123, // Mock ID
            name: "Mock Exercise", // Mock name
            uuid: "123e4567-e89b-12d3-a456-426655440000", // Mock UUID
            exerciseBaseID: 456, // Mock base ID
            description: "This is a mock exercise used for testing.", // Mock description
            created: "2024-01-08", // Mock creation date
            images: [ExerciseImage.mock()], // Mock images, using a similar mock method in ExerciseImage
            variations: [1, 10] // Mock variations
        )
    }
}
