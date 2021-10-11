//
//  PostImageCache.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 10/10/21.
//

import Foundation

// MARK: - Protocol declaration of ImageCache
protocol ImageCache {
    func getImageData(withKey key: String) -> Data?
    func saveImage(data: Data, withKey key: String)
}

// MARK: - Concrete implementation of PhotoImageCache
class PhotoImageCache: ImageCache {
    private var cache = NSCache<NSString,NSData>()
    
    func getImageData(withKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func saveImage(data: Data, withKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
}
