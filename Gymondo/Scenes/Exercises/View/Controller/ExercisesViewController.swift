//
//  ExercisesViewController.swift
//  Gymondo
//
//  Created by Amir Daliri on 7.01.2024.
//

import UIKit
import Combine
import SwiftUI

class ExercisesViewController: UIViewController, Loading {
    
    @IBOutlet weak var tableView: UITableView!
    var spinner: UIView?

    private var viewModel: ExercisesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // UI Components (e.g., UITableView, UICollectionView, etc.)
    init(viewModel: ExercisesViewModel = ExercisesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Exercises"
        setupTableView()
        viewModel = ExercisesViewModel()
        bindViewModel()
        viewModel.loadExercises()
    }
    
    private func bindViewModel() {
        showSpinner()
        viewModel.$exercises
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.hideSpinner()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$networkError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.hideSpinner()
                self?.handleNetworkError(error)
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        tableView.register(type: ExerciseTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "ExerciseTableView"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func updateUI() {
        // Update your UI with the data from the viewModel
        print(viewModel.exercises)
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        // Handle the error, e.g., show an alert
        let message = determineErrorMessage(for: error)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func determineErrorMessage(for error: NetworkError) -> String {
        switch error {
        case .invalidURL, .invalidResponse, .noData:
            return "A network error occurred. Please try again."
        case .underlyingError(let underlyingError):
            return underlyingError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError.localizedDescription
        case .notFound:
            return "not Found"
        case .otherError(let message):
            return message
        }
    }
}

// MARK: - Table Delegate Datasource
extension ExercisesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
        cell.setup(exercise: viewModel.exercises[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise = viewModel.exercises[indexPath.row]
        DispatchQueue.main.async {
            self.navigateToExerciseDetail(with: selectedExercise)
        }
    }

    private func navigateToExerciseDetail(with exercise: Exercise) {
        guard let networkService = self.viewModel.networkService as? NetworkManager else { return }
        let detailView = ExerciseDetailView(viewModel: ExerciseDetailViewModel(networkManager: networkService, exercise: exercise))
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
