//
//  DecodingTests.swift
//  GymondoTests
//
//  Created by Amir Daliri on 7.01.2024.
//

import XCTest
import Combine
@testable import Gymondo

final class DecodingTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testFetchExercisesSuccess() {
        // Attempt to load and decode the JSON data from ExerciseSuccessResponse.json
        guard let jsonData = TestUtilities.shared.loadJson(from: "ExerciseSuccessResponse"),
              let mockExercise = try? JSONDecoder().decode(Exercises.self, from: jsonData) else {
            XCTFail("Failed to load or decode ExerciseSuccessResponse.json")
            return
        }

        // Set up the mock network service with the decoded mock exercise data
        let service = MockNetworkService(exercisesResult: .success(mockExercise))
        let expectation = XCTestExpectation(description: "Fetch exercises successfully")

        // Perform the network request using the mock service
        service.fetchExercises()
            .sink(receiveCompletion: { _ in }, receiveValue: { exercise in
                // Assert that the received exercise data matches the mock data
                XCTAssertEqual(exercise.results?.count, mockExercise.results?.count)
                XCTAssertEqual(exercise.results?.first?.created, mockExercise.results?.first?.created)
                expectation.fulfill() // Fulfill the expectation upon successful assertion
            })
            .store(in: &cancellables)

        // Wait for the test expectations to be fulfilled or time out
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDecodingExerciseResult() {
        // Given: Load and use JSON data representing a single ExerciseResult
        guard let jsonData = TestUtilities.shared.loadJson(from: "ExerciseResultSample") else {
            XCTFail("Failed to load JSON for ExerciseResult")
            return
        }

        // When: Attempt to decode the JSON into an ExerciseResult object
        let result = try? JSONDecoder().decode(Exercise.self, from: jsonData)

        // Then: Verify that the result is not nil and the properties match the expected values
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, 31)
        XCTAssertEqual(result?.name, "Addominali")
        XCTAssertEqual(result?.uuid, "sample uuid")
        XCTAssertEqual(result?.created, "sample created")
    }
    
    func testDecodingCompleteExerciseObject() {
        // Given: Load and use JSON data representing a complete Exercise object
        guard let jsonData = TestUtilities.shared.loadJson(from: "ExerciseSuccessResponse") else {
            XCTFail("Failed to load JSON for Complete Exercise")
            return
        }

        // When: Attempt to decode the JSON into an Exercise object
        let exercise = try? JSONDecoder().decode(Exercises.self, from: jsonData)

        // Then: Verify that the decoding is successful and properties match expected values
        XCTAssertNotNil(exercise, "Decoding result should not be nil")
        XCTAssertEqual(exercise?.count, 2, "The count should match the JSON data")
        XCTAssertEqual(exercise?.next, "next_page_url", "The 'next' property should match the JSON data")
        XCTAssertEqual(exercise?.previous, "previous_page_url")

        // Verify the first ExerciseResult in the results array
        let firstResult = exercise?.results?.first

        // Then: Verify that the Exercise object and its properties are decoded correctly
        XCTAssertNotNil(firstResult, "First result should not be nil")
        XCTAssertEqual(firstResult?.id, 1314, "The id of the first result should match the JSON data")
        XCTAssertEqual(firstResult?.created, "Sample created")
    }
    
    func testDecodingInvalidJSON() {
        // Given: An invalid JSON string
        let invalidJsonData = "Invalid JSON".data(using: .utf8)!
        let decoder = JSONDecoder()

        // When: Attempting to decode the invalid JSON into an ExerciseResult object
        let result = try? decoder.decode(Exercise.self, from: invalidJsonData)

        // Then: Verify that the result is nil, indicating a decoding failure
        XCTAssertNil(result)
    }
    
    func testNotFound() {
        // Given: Load and use JSON data representing a complete ErrorResponse object
        guard let jsonData = TestUtilities.shared.loadJson(from: "ExerciseErrorResponse") else {
            XCTFail("Failed to load JSON for Complete Exercise")
            return
        }
        
        // When: Attempt to decode the JSON into an ErrorResponse object
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: jsonData)
        
        // Then: Verify that the decoding is successful and properties match expected values
        XCTAssertNotNil(errorResponse, "Decoding result should not be nil")
    }
}
