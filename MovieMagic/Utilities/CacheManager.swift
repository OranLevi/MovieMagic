//
//  CacheManager.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import Foundation
import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    
    private init(){}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func addToCache(image: UIImage, name: String){
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func get(name: String) ->UIImage? {
        return imageCache.object(forKey: name as NSString)
        
    }
    
}
