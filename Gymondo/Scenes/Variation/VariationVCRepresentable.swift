//
//  VariationVCRepresentable.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//


import SwiftUI

// A SwiftUI representable for VariationViewController to integrate it within SwiftUI views.
struct VariationVCRepresentable: UIViewControllerRepresentable {
    // The exercise variation to be displayed in the view controller.
    var variation: Exercise
    
    // Creates and returns an instance of VariationViewController.
    // This method is called by SwiftUI when it's ready to display the view.
    // - Parameter context: The context in which the view controller is created.
    // - Returns: An instance of VariationViewController configured with the given exercise variation.
    func makeUIViewController(context: Context) -> VariationViewController {
        // Initialize the VariationViewController with the provided exercise variation.
        VariationViewController(variation: variation)
    }
    
    // Updates the configuration of the view controller in response to SwiftUI state changes.
    // - Parameters:
    //   - uiViewController: The VariationViewController that needs to be updated.
    //   - context: The context in which the view controller is updated.
    func updateUIViewController(_ uiViewController: VariationViewController, context: Context) {
        // Update the view controller if needed.
        // This method is used to update the view controller with new data when SwiftUI state changes.
        // Currently, there's no implementation here as the exercise variation does not change dynamically in this context.
    }
}
