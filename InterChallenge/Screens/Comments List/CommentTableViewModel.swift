//
//  CommentTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 07/10/21.
//

import Foundation
import Combine

class CommentTableViewModel: ObservableObject {
    // MARK: - Bindings properties
    @Published private(set) var comments = [Comment]()
    @Published private(set) var errorMessage: String = ""
    
    // MARK: - Private properties
    private let repository: CommentRepository
    private let user: User
    private let post: Post
    
    init(user: User, post: Post, repository: CommentRepository) {
        self.repository = repository
        self.post = post
        self.user = user
    }
    
    func fillComments() {
        repository.getCommentsFrom(postId: post.id) { result in
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .success(let fetchedComments):
                self.comments = fetchedComments
            }
        }
    }
}

// MARK: - Computed properties
extension CommentTableViewModel {
    var navigationBarTitle: String {
        "Comentários de \(user.name)"
    }
}
