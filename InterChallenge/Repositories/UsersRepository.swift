//
//  Repository.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 05/10/21.
//

import Foundation
import Alamofire

protocol UsersRepository {
    func getUsers(completion: @escaping (Result<[User], RepositoryError>) -> ())
}

enum RepositoryError : Error {
    case networkError
    case responseError
    case serializationError
}

class WebUserRepository: UsersRepository {
    func getUsers(completion: @escaping (Result<[User], RepositoryError>) -> ()) {
        AF.request("https://jsonplaceholder.typicode.com/users")
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completion(.failure(.responseError))
                    return
                }
                
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([User].self, from: data)
                        completion(.success(models))
                    }
                } catch {
                    completion(.failure(.serializationError))
                }
        }
    }
}
