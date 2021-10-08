//
//  AlbumsRepository.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 05/10/21.
//

import Foundation
import Alamofire

protocol AlbumsRepository {
    func getAlbumsOf(userId: Int, completion: @escaping (Result<[Album], RepositoryError>) -> ())
}

class WebAlbumsRepository: AlbumsRepository {
    func getAlbumsOf(userId: Int, completion: @escaping (Result<[Album], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(userId)")
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completion(.failure(.responseError))
                    return
                }
                
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Album].self, from: data)
                        completion(.success(models))
                    }
                } catch {
                    completion(.failure(.serializationError))
                }
        }
    }
}
