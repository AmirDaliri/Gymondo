//
//  VariationViewController.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import UIKit

class VariationViewController: UIViewController {
    
    var variation: Exercise // Assuming this now contains the variation info
    
    private lazy var variationView = VariationView()

    
    init(variation: Exercise) {
        self.variation = variation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "test"
        setupVariationView()
        variationView.configure(with: variation)
    }
    
    private func setupVariationView() {
        view.addSubview(variationView)
        variationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            variationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            variationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            variationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            variationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
