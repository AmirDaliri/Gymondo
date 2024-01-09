//
//  ExerciseDetailView.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import SwiftUI
import Kingfisher

struct ExerciseDetailView: View {
    
    @StateObject var viewModel: ExerciseDetailViewModel

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 0) {

                exerciseImageView()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 32)
                
                descriptionView()

                if viewModel.isLoading {
                    ProgressView("Loading Variations...")
                } else {
                    if !viewModel.variations.isEmpty {
                        Text("Variations")
                            .padding()
                            .font(.headline)

                        variationLinks()
                    }
                }

                // Handle errors
                if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                }
                Spacer()
            }
        }
        .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9098039216, blue: 0.8901960784, alpha: 1)))
        .onAppear {
            DispatchQueue.main.async {
                if viewModel.shouldFetchDetails {
                    viewModel.loadExerciseDetails()
                }
            }
        }
    }
    
    @ViewBuilder
    private func variationLinks() -> some View {
        ForEach(viewModel.variations, id: \.id) { variation in
            NavigationLink(destination: VariationVCRepresentable(variation: variation)) {
                variationView(variation: variation)
            }
            .frame(height: 44)
            .padding(.top)
            .padding(.horizontal, 18)
        }
    }
    
    @ViewBuilder
    private func variationView(variation: Exercise) -> some View {
        HStack {
            Spacer()
            Text(variation.name ?? "Unknown Exercise")
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.black)
        }
        .padding()
        .background(Color.orange)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black.opacity(0.2), lineWidth: 0.5)
        )
    }
    
    
    @ViewBuilder
    private func exerciseImageView() -> some View {
        
        if let imageUrl = viewModel.mainImageUrl {

            KFImage(imageUrl)
                .resizable()
                .placeholder {
                    // Placeholder while downloading.
                    placeholderImageView()
                }
                .retry(maxCount: 3, interval: .seconds(5))
                .frame(height: 250)
                .background(Color.white)
        } else {
            placeholderImageView()
        }
    }
    
    @ViewBuilder
    private func placeholderImageView() -> some View {
        Image("placeholder").resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 48)
            .frame(height: 250)
            .opacity(0.3)
    }

    
    @ViewBuilder
    private func descriptionView() -> some View {
        VStack {
            // Exercise Name
            Text(viewModel.exerciseName ?? "")
                .font(.headline)
                .padding()
            
            Text(viewModel.exerciseDescription?.html2String ?? "")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .lineSpacing(4.0)

        }
    }
}

#Preview {
    ExerciseDetailView(viewModel: ExerciseDetailViewModel.init(exercise: .mock()))
}
