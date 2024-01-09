//
//  ExerciseDetailViewModel.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import Foundation
import Combine
import SwiftUI

// ViewModel for managing and presenting details of a specific exercise.
class ExerciseDetailViewModel: ObservableObject {
    
    // Published properties to update the view when data changes.
    @Published var variations: [Exercise] = [] // Variations of the current exercise.
    @Published var isLoading = false // Tracks the loading state of the network request.
    @Published var error: NetworkError? // Stores any network error that occurs.
    
    internal var cancellables = Set<AnyCancellable>() // Manages memory for network requests.
//    private var networkManager: NetworkServiceProtocol // Network manager for API calls.
    private(set) var networkManager: NetworkServiceProtocol

    private var exercise: Exercise // The exercise whose details are being shown.
    
    // Computed properties to expose specific details of the exercise to the view.
    var exerciseName: String? {
        exercise.name
    }
    
    var exerciseDescription: String? {
        exercise.description
    }
    
    var mainImageUrl: URL? {
        exercise.getMainImageUrl()
    }
    
    // Boolean flag to determine if exercise details need to be fetched.
    var shouldFetchDetails: Bool {
        return exercise.id != nil && variations.isEmpty
    }
    
    // Initializer for the view model.
    // - Parameters:
    //   - networkManager: An instance of NetworkManager for making network requests.
    //   - exercise: The exercise whose details are to be displayed.
    init(networkManager: NetworkServiceProtocol = NetworkManager(), exercise: Exercise) {
        self.networkManager = networkManager
        self.exercise = exercise
    }
    
    // Function to load exercise details, specifically the variations.
    func loadExerciseDetails() {
        DispatchQueue.main.async {
            self.fetchVariations(for: self.exercise)
        }
    }
    
    // Private function to fetch exercise variations.
    // - Parameter exercise: The exercise for which variations are to be fetched.
    private func fetchVariations(for exercise: Exercise) {
        guard let variationIDs = exercise.variations, !variationIDs.isEmpty else {
            self.variations = []
            return
        }
        
        // Start loading
        isLoading = true
        
        // Fetch all variations and handle the response.
        networkManager.fetchAllVariations(variationIDs: variationIDs, delaySeconds: 0.2)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false // Stop loading
                if case let .failure(error) = completion {
                    self?.error = error // Store error if any
                }
            }, receiveValue: { [weak self] exercises in
                self?.variations = exercises // Store fetched variations
            })
            .store(in: &cancellables) // Manage cancellable
    }
}
