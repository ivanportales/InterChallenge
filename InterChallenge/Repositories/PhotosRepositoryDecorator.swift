//
//  PhotosRepositoryDecorator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 08/10/21.
//

import Foundation

protocol ImageCache {
    func getImageData(withKey key: String) -> Data?
    func saveImage(data: Data, withKey key: String)
}

protocol PhotosRepositoryDecorator: PhotosRepository {
    var defaultRepo: PhotosRepository { get }
}

class PhotoImageCache: ImageCache {
    private var cache = NSCache<NSString,NSData>()
    
    func getImageData(withKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func saveImage(data: Data, withKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
}

class PhotosRepositoryCacheDecorator: PhotosRepositoryDecorator {
    private let cache: ImageCache
    let defaultRepo: PhotosRepository
    
    init(cache: ImageCache, repository: PhotosRepository) {
        self.cache = cache
        self.defaultRepo = repository
    }
    
    func getPhotosFrom(albumId: Int, completion: @escaping (Result<[Photo], RepositoryError>) -> ()) {
        defaultRepo.getPhotosFrom(albumId: albumId, completion: completion)
    }
    
    func getImageDataOf(stringUrl: String, completion: @escaping (Result<Data, RepositoryError>) -> ()) {
        guard let imageData = cache.getImageData(withKey: stringUrl) else {
            defaultRepo.getImageDataOf(stringUrl: stringUrl) {[weak self] result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let self = self else {return}
                    self.cache.saveImage(data: data, withKey: stringUrl)
                    completion(.success(data))
                }
            }
            return 
        }
        
        completion(.success(imageData))
    }
}
