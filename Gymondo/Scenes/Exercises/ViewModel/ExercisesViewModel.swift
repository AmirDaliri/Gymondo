//
//  ExercisesViewModel.swift
//  Gymondo
//
//  Created by Amir Daliri on 6.01.2024.
//

import Combine

// ViewModel for handling exercises data in the application.
class ExercisesViewModel {
    
    // Published properties that will update the view when changed.
    @Published var exercises: [Exercise] = [] // Array of Exercise objects.
    @Published var networkError: NetworkError? = nil // Stores potential network errors.
    
    // Set of AnyCancellable objects for managing memory and life cycle of network requests.
    var cancellables = Set<AnyCancellable>()
    // The network service responsible for fetching exercise data.
    let networkService: NetworkServiceProtocol

    // Initializer for the view model. It defaults to using NetworkManager for network operations.
    // - Parameter networkService: The network service to use for fetching data. Defaults to NetworkManager.
    init(networkService: NetworkServiceProtocol = NetworkManager()) {
        self.networkService = networkService
    }

    // Function to load exercises from the network.
    func loadExercises() {
        networkService.fetchExercises()
            .sink(receiveCompletion: { [weak self] completion in
                // Handle the completion of the network request.
                switch completion {
                case .failure(let error):
                    // If there's an error, store it in networkError.
                    self?.networkError = error
                case .finished:
                    // No action needed if the network request finishes successfully.
                    break
                }
            }, receiveValue: { [weak self] exercises in
                // Receive the exercises and store them in the exercises property.
                self?.exercises = exercises.results ?? []
            })
            // Store the cancellable instance in the set to manage its lifecycle.
            .store(in: &cancellables)
    }
}
