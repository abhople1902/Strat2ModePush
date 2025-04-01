//
//  MainNewsModel.swift
//  Downforce
//
//  Created by Ayush Bhople on 19/03/25.
//

import Foundation

struct MainNewsModel: Codable {
    let totalResults: Int?
    let articles: [MainNews]?
}

struct MainNews: Codable {
    let source: Source?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt : String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
