//
//  Articles.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation

struct Article: Codable {
    let articles: [Products]
}

struct Products: Codable {
    let id: Int
    let title: String
    let bodyHTML: String
    let image: Image
    let summaryHTML: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case bodyHTML = "body_html"
        case image
        case summaryHTML = "summary_html"
    }
}

struct Image: Codable {
    let width, height: Int
    let src: String
}
