//
//  File.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 21/03/25.
//

import UIKit

extension String {
    // Function to strip html tags from the response key (summaryHTML)
    func stripHTMLTags() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        return self
    }
}
