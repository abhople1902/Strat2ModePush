//
//  NewsImageViewModel.swift
//  Downforce
//
//  Created by Ayush Bhople on 31/03/25.
//

import UIKit

class NewsImageViewModel {
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.absoluteString
        
        if let cachedImage = NewsImageCache.shared.getImage(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            NewsImageCache.shared.setImage(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
