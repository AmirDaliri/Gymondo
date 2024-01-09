//
//  ExerciseViewModelTests.swift
//  GymondoTests
//
//  Created by Amir Daliri on 7.01.2024.
//

import XCTest
import Combine
@testable import Gymondo

class ExercisesViewModelTests: XCTestCase {
    
    var viewModel: ExercisesViewModel!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        // Providing a default result for initialization
        let defaultResult: Result<Exercises, NetworkError> = .success(Exercises(results: []))
        mockNetworkService = MockNetworkService(exercisesResult: defaultResult)

        // Ensure that MockNetworkService conforms to NetworkServiceProtocol
        viewModel = ExercisesViewModel(networkService: mockNetworkService)
        cancellables = []

    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoadExercises_Success() {
        // Given: A successful response from the network service
        let expectedExercises = [Exercise(id: 1, name: "Exercise 1"), Exercise(id: 2, name: "Exercise 2")]
        mockNetworkService.exercisesResult = .success(Exercises(results: expectedExercises))

        // When: Loading exercises
        viewModel.loadExercises()

        // Then: Exercises array in view model should be updated
        XCTAssertEqual(viewModel.exercises, expectedExercises)
    }

    func testLoadExercises_Error() {
        // Given: An error response from the network service
        let expectedError = NetworkError.noData
        mockNetworkService.exercisesResult = .failure(expectedError)

        // Expectation for async response
        let expectation = self.expectation(description: "Error handling in view model")
        viewModel.$networkError
            .sink { error in
                if error == expectedError {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When: Loading exercises
        viewModel.loadExercises()

        // Then: NetworkError property in view model should be updated
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

