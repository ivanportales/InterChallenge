//
//  CommentRepository.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 05/10/21.
//

import Foundation
import Alamofire

protocol CommentRepository {
    func getCommentsFrom(postId: Int, completion: @escaping (Result<[Comment], RepositoryError>) -> ())
}

class WebCommentRepository: CommentRepository {
    func getCommentsFrom(postId: Int, completion: @escaping (Result<[Comment], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/comments?postId=\(postId)")
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completion(.failure(.responseError))
                    return
                }
                
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Comment].self, from: data)
                        completion(.success(models))
                    }
                } catch {
                    completion(.failure(.serializationError))
                }
        }
    }
}
