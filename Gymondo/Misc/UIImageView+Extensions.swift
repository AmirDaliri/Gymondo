//
//  UIImageView-Extensions.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import UIKit
import Kingfisher
/**
 An extension for `UIImageView` to asynchronously load an image from a URL using Kingfisher.
 
 This extension provides a convenient way to load and display images from a URL in a UIImageView asynchronously. It uses the Kingfisher library for efficient image loading and caching. If the URL is invalid or the image cannot be loaded, a placeholder image with reduced alpha is shown.
 
 ## Usage Example:
 ```swift
 // Create a UIImageView and set its image from a URL string.
 let imageView = UIImageView()
 imageView.setImage(with: "https://example.com/image.jpg")
 Note: Make sure to import the Kingfisher library in your project to use this extension.
 */
extension UIImageView {
    
    /**
     Sets an image from a URL string asynchronously.
     
     Parameters:
     
     urlString: The URL string of the image to be loaded.
     
     options: Optional KingfisherOptionsInfo to customize the image loading process.
     
     completionHandler: Optional closure to be called after the image loading is completed, containing the result or an error.
     */
    // Sets an image from a URL string. If the URL is invalid or the image cannot be loaded, a placeholder with reduced alpha is shown.
    // - Parameters:
    //   - urlString: The URL string of the image to be loaded.
    //   - options: Optional KingfisherOptionsInfo to customize the image loading process.
    //   - completionHandler: Optional closure to be called after the image loading is completed, containing the result or an error.
    func setImage(with urlString: String?, options: KingfisherOptionsInfo? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        // Guard clause to check and unwrap the urlString.
        // If urlString is nil or cannot be converted to a URL, set a placeholder image with reduced alpha and trigger a failure completion handler.
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = UIImage(named: "placeholder") // Set a default placeholder image.
            self.alpha = 0.3 // Set alpha to 0.3 for the placeholder image.
            
            // Create a dummy URLRequest to satisfy the type requirement in the failure handler.
            let dummyRequest = URLRequest(url: URL(string: "https://example.com")!)
            
            // Call the completion handler with a failure result.
            completionHandler?(.failure(KingfisherError.requestError(reason: .invalidURL(request: dummyRequest))))
            return
        }
        
        // Use Kingfisher's setImage method to load the image from the URL.
        // Optionally includes a placeholder image and other options.
        // Resets the alpha to 1.0 if the image is loaded successfully.
        // The completion handler is called upon the completion of the image loading process.
        kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: options) { result in
            switch result {
            case .success(_):
                self.alpha = 1.0 // Reset alpha back to 1.0 if the image is loaded successfully.
            case .failure(_):
                self.alpha = 0.3 // Keep alpha at 0.3 in case of failure.
            }
            completionHandler?(result)
        }
    }
}
