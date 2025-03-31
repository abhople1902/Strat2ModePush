//
//  NewsImageCache.swift
//  Downforce
//
//  Created by Ayush Bhople on 31/03/25.
//

import Foundation
import UIKit

class NewsImageCache {
    static let shared = NewsImageCache()
//    private var cache: [String: UIImage] = [:]
//    
//    public func storeImage(_ image: UIImage, forKey key: String) {
//        cache[key] = image
//    }
//    
//    public func image(forKey key: String) -> UIImage? {
//        return cache[key]
//    }
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

