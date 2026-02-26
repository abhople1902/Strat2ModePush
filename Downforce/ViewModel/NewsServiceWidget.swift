//
//  NewsServiceWidget.swift
//  Downforce
//
//  Created by Ayush Bhople on 25/02/26.
//



import Foundation

struct NewsServiceWidget {
    static let shared = NewsServiceWidget()
    private let session = URLSession(configuration: .default)
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        return decoder
    }()
    
    private let endpoint = URL(string: "https://newsapi.org/v2/top-headlines?sources=bbc-sport&apiKey=8acdf1145d14476091edab5f5f8a5cd7")!
    
    func fetchTopHeadForWidget() async throws -> [MainNews] {
        let (data, response) = try await session.data(from: endpoint)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let results = try? decoder.decode(MainNewsModel.self, from: data)
        return results?.articles ?? []
    }
}
