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
    @Published private(set) var errorMessage: String = ""
    private let coordinator: MainCoordinator
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
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .success(let fetchedPosts):
                self.posts = fetchedPosts
            }
        }
    }
    
    func showCommentsOf(post: Post) {
        coordinator.showCommentsIn(post: post, ofUser: user)
    }
}
