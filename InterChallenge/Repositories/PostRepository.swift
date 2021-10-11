//
//  PostRepository.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 05/10/21.
//

import Foundation
import Alamofire

// MARK: - Protocol declaration of PostRepository
protocol PostRepository {
    func getPostsFrom(userId: Int, completion: @escaping (Result<[Post], RepositoryError>) -> ())
}

// MARK: - Concrete implementation of PostRepository
class WebPostsRepository: PostRepository {
    func getPostsFrom(userId: Int, completion: @escaping (Result<[Post], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completion(.failure(.responseError))
                    return
                }
                
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Post].self, from: data)
                        completion(.success(models))
                    }
                } catch {
                    completion(.failure(.serializationError))
                }
        }
    }
}
