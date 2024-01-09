//
//  UILabel+Extensions.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import UIKit

// Extension on Data to handle HTML content.
extension Data {
    
    // Converts HTML data to an attributed string.
    // - Returns: An optional NSAttributedString if the conversion is successful; otherwise, nil.
    var html2AttributedString: NSAttributedString? {
        do {
            // Tries to create an NSAttributedString from HTML data with UTF-8 encoding.
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            // If there is an error in conversion, it is printed to the console and nil is returned.
            print("error:", error)
            return nil
        }
    }
    
    // Converts HTML data to a plain string.
    // - Returns: A String representation of the HTML data, or an empty string if conversion fails.
    var html2String: String { html2AttributedString?.string ?? "" }
}

// Extension for StringProtocol to handle HTML content.
extension StringProtocol {
    
    // Converts HTML string to an attributed string.
    // - Returns: An optional NSAttributedString if the conversion is successful; otherwise, nil.
    var html2AttributedString: NSAttributedString? {
        // Converts the string to Data and then attempts to convert to an attributed string.
        Data(utf8).html2AttributedString
    }
    
    // Converts HTML string to a plain string.
    // - Returns: A String representation of the HTML content, or an empty string if conversion fails.
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

