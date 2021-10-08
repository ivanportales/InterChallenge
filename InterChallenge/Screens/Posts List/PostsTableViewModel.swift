//
//  PostsTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 07/10/21.
//

import Foundation
import Combine

class PostsTableViewModel: ObservableObject {
    @Published private(set) var posts = [Post]()
    private weak var coordinator: MainCoordinator?
    private let repository: PostRepository
    private let user: User
    
    var navigationBarTitle: String {
        user.name
    }
    
    init(user: User, repository: PostRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.user = user
        self.coordinator = coordinator
    }
    
    func fillPosts() {
        repository.getPostsFrom(userId: user.id) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
//                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//                    alert.dismiss(animated: true)
//                }))
//                self.present(alert, animated: true)
            case .success(let fetchedPosts):
                guard let self = self else { return }
                self.posts = fetchedPosts
            }
        }
    }
    
    func showCommentsOf(post: Post) {
        coordinator?.showCommentsIn(post: post, ofUser: user)
    }
}
