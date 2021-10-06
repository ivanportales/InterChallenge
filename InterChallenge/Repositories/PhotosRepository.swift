//
//  PhotosRepository.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 05/10/21.
//

import Foundation
import Alamofire

protocol PhotosRepository {
    func getPhotosFrom(albumId: Int, completion: @escaping (Result<[Photo], RepositoryError>) -> ())
}

class WebPhotoRepository: PhotosRepository {
    func getPhotosFrom(albumId: Int, completion: @escaping (Result<[Photo], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)").validate().responseJSON { response in
            guard response.error == nil else {
                completion(.failure(.responseError))
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Photo].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(models))
                    }
                }
            } catch {
                completion(.failure(.serializationError))
            }
        }
    }
}
