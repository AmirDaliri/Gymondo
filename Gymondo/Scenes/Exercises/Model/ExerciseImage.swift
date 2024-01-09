//
//  ExerciseImage.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import Foundation

// Struct representing an image associated with an exercise.
struct ExerciseImage: Decodable {
    // Properties representing various attributes of an exercise image.
    let id: Int?
    let uuid: String?
    // Reference to the base exercise by ID and UUID.
    let exerciseBase: Int?
    let exerciseBaseUUID: String?
    // URL string of the image.
    let image: String?
    // Indicates if this image is the main image for the exercise.
    let isMain: Bool?
    // Style description of the image.
    let style: String?
    // License information related to the image.
    let license: Int?
    let licenseTitle, licenseObjectURL, licenseAuthor, licenseAuthorURL: String?
    // URL for the source of the derivative work, if applicable.
    let licenseDerivativeSourceURL: String?
    // History of authors contributing to the image.
    let authorHistory: [String]?
    
    // Custom coding keys for JSON decoding, to handle different property names.
    enum CodingKeys: String, CodingKey {
        case id, uuid
        case exerciseBase = "exercise_base"
        case exerciseBaseUUID = "exercise_base_uuid"
        case image
        case isMain = "is_main"
        case style, license
        case licenseTitle = "license_title"
        case licenseObjectURL = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorURL = "license_author_url"
        case licenseDerivativeSourceURL = "license_derivative_source_url"
        case authorHistory = "author_history"
    }
    
    // Custom initializer to create an instance of ExerciseImage.
    // All parameters are optional, allowing for flexibility in initialization.
    init(id: Int? = nil, uuid: String? = nil, exerciseBase: Int? = nil, exerciseBaseUUID: String? = nil, image: String? = nil, isMain: Bool? = nil, style: String? = nil, license: Int? = nil, licenseTitle: String? = nil, licenseObjectURL: String? = nil, licenseAuthor: String? = nil, licenseAuthorURL: String? = nil, licenseDerivativeSourceURL: String? = nil, authorHistory: [String]? = nil) {
        self.id = id
        self.uuid = uuid
        self.exerciseBase = exerciseBase
        self.exerciseBaseUUID = exerciseBaseUUID
        self.image = image
        self.isMain = isMain
        self.style = style
        self.license = license
        self.licenseTitle = licenseTitle
        self.licenseObjectURL = licenseObjectURL
        self.licenseAuthor = licenseAuthor
        self.licenseAuthorURL = licenseAuthorURL
        self.licenseDerivativeSourceURL = licenseDerivativeSourceURL
        self.authorHistory = authorHistory
    }
}

// Extension to ExerciseImage for custom equality comparison.
extension ExerciseImage: Equatable {
    // Custom equality operator to compare two ExerciseImage objects.
    // Compares all properties to determine if two instances are equal.
    static func == (lhs: ExerciseImage, rhs: ExerciseImage) -> Bool {
        return lhs.id == rhs.id &&
        lhs.uuid == rhs.uuid &&
        lhs.exerciseBase == rhs.exerciseBase &&
        lhs.exerciseBaseUUID == rhs.exerciseBaseUUID &&
        lhs.image == rhs.image &&
        lhs.isMain == rhs.isMain &&
        lhs.style == rhs.style &&
        lhs.license == rhs.license &&
        lhs.licenseTitle == rhs.licenseTitle &&
        lhs.licenseObjectURL == rhs.licenseObjectURL &&
        lhs.licenseAuthor == rhs.licenseAuthor &&
        lhs.licenseAuthorURL == rhs.licenseAuthorURL &&
        lhs.licenseDerivativeSourceURL == rhs.licenseDerivativeSourceURL &&
        lhs.authorHistory == rhs.authorHistory
    }
}

extension ExerciseImage {
    // Static function to create a mock ExerciseImage instance.
    static func mock() -> ExerciseImage {
        return ExerciseImage(
            id: 1, // Mock ID
            uuid: "123e4567-e89b-12d3-a456-426655440001", // Mock UUID
            exerciseBase: 123, // Mock exercise base
            exerciseBaseUUID: "123e4567-e89b-12d3-a456-426655440000", // Mock exercise base UUID
            image: "https://wger.de/media/exercise-images/91/Crunches-1.png", // Mock image URL
            isMain: true, // Mock isMain flag
            style: "Mock Style", // Mock style
            license: 2, // Mock license
            licenseTitle: "Mock License", // Mock license title
            licenseObjectURL: "https://example.com/license", // Mock license URL
            licenseAuthor: "Mock Author", // Mock author
            licenseAuthorURL: "https://example.com/author", // Mock author URL
            licenseDerivativeSourceURL: "https://example.com/source", // Mock derivative source URL
            authorHistory: ["Mock Author 1", "Mock Author 2"] // Mock author history
        )
    }
}
