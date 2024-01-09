//
//  ExerciseDetailViewModelTests.swift
//  GymondoTests
//
//  Created by Amir Daliri on 9.01.2024.
//

import XCTest
import Combine
@testable import Gymondo

class ExerciseDetailViewModelTests: XCTestCase {
    
    // Create a mock network service for testing
    var mockNetworkService = MockNetworkService()
    var cancellables: Set<AnyCancellable> = []
    var viewModel: ExerciseDetailViewModel!

    override func setUp() {
        super.setUp()
        // Providing a default result for initialization
        let defaultResult: Result<Exercises, NetworkError> = .success(Exercises(results: []))
        mockNetworkService = MockNetworkService(exercisesResult: defaultResult)

        // Ensure that MockNetworkService conforms to NetworkServiceProtocol
        viewModel = ExerciseDetailViewModel(exercise: Exercise())
        cancellables = []

    }
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    // Helper function to create a test view model
    func createTestViewModel(
        variationsResult: Result<[Exercise], NetworkError> = .success([]),
        exercise: Exercise = Exercise()
    ) -> ExerciseDetailViewModel {
        mockNetworkService.variationsResult = variationsResult
        return ExerciseDetailViewModel(networkManager: mockNetworkService, exercise: exercise)
    }
    
    func testLoadExerciseDetails_Success() {
        // Create a mock network service with a successful result (empty array)
        let mockNetworkService = MockNetworkService(variationsResult: .success([Exercise]()))
        
        // Create the view model with the mock network service
        let viewModel = ExerciseDetailViewModel(networkManager: mockNetworkService, exercise: Exercise())
        
        // Create an expectation with a meaningful description
        let expectation = XCTestExpectation(description: "Exercise details loaded successfully")
        
        // Load exercise details (asynchronous operation)
        viewModel.loadExerciseDetails()
        
        // Delay to give time for the asynchronous operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Check isLoading and variations here (print statements for debugging)
            print("isLoading: \(viewModel.isLoading)")
            print("variations count: \(viewModel.variations.count)")
            
            // Check isLoading and variations
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.variations.isEmpty) // This should be empty
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled, with a timeout
        wait(for: [expectation], timeout: 5.0)
    }    
}
