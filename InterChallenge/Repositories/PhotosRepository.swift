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
    func getImageDataOf(stringUrl: String, completion: @escaping (Result<Data, RepositoryError>) -> ())
}

class WebPhotoRepository: PhotosRepository {
    func getImageDataOf(stringUrl: String, completion: @escaping (Result<Data, RepositoryError>) -> ()) {
        AF.download(stringUrl)
            .validate()
            .responseData { response in
                guard response.error == nil else {
                    completion(.failure(.responseError))
                    return
                }
                
                switch response.result {
                case . failure(_):
                    completion(.failure(.serializationError))
                case .success(let data):
                    completion(.success(data))
                }
        }
    }
    
    func getPhotosFrom(albumId: Int, completion: @escaping (Result<[Photo], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)")
            .validate()
            .responseJSON { response in
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
