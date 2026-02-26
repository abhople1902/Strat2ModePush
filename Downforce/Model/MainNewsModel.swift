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

extension MainNews {
    static var placeholderForWidget: MainNews {
        MainNews(
            source: Source(id: "bbc-sport", name: "BBC Sport"),
            title: "Aston Martin: Why they are in trouble before 2026 season starts",
            description: "The combination of Adrian Newey, Honda and Fernando Alonso was highly promising but Aston Martin are in trouble. Andrew Benson explains why.",
            url: "http://www.bbc.co.uk/sport/formula1/articles/cr45w421yg4o",
            urlToImage: "https://ichef.bbci.co.uk/ace/branded_sport/1200/cpsprodpb/a0dd/live/7125a740-10c9-11f1-912a-116949699904.jpg",
            publishedAt: "2026-02-24T07:22:23.9869067Z"
        )
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
