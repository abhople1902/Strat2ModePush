//
//  APIManager.swift
//  Downforce
//
//  Created by Ayush Bhople on 19/03/25.
//

import Foundation

protocol MainNewsFetcherDelegate {
    func didFetchMainNews(_ apiManager: APIManager, mainNewsModel: MainNewsModel)
    func didFailWithError(error: Error)
}

struct APIManager {
    
    var delegate: MainNewsFetcherDelegate?
    
    let mainNewsUrl = "https://newsapi.org/v2/top-headlines?sources=bbc-sport&apiKey=8acdf1145d14476091edab5f5f8a5cd7"
    
    func fetchMainStreamCNNNews() {
        fetchNews(with: mainNewsUrl)
    }
    
    func fetchNews(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let parsedData = parseJSONForMainNews(safeData) {
                        self.delegate?.didFetchMainNews(self, mainNewsModel: parsedData)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSONForMainNews(_ newsData: Data) -> MainNewsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainNewsModel.self, from: newsData)
            let totalResults = decodedData.totalResults
            let articles = decodedData.articles
            
            let news = MainNewsModel(totalResults: totalResults, articles: articles)
            return news
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}



