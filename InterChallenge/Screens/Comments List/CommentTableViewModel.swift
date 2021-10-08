//
//  CommentTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 07/10/21.
//

import Foundation
import Combine

class CommentTableViewModel: ObservableObject {
    @Published private(set) var comments = [Comment]()
    @Published private(set) var errorMessage: String = ""
    private let repository: CommentRepository
    private let user: User
    private let post: Post
    
    var navigationBarTitle: String {
        user.name
    }
    
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
