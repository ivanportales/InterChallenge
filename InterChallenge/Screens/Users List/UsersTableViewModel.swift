//
//  UsersTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import Combine

class UsersTableViewModel: ObservableObject {
    @Published private(set) var users = [User]()
    @Published private(set) var errorMessage: String = ""
    private let coordinator: MainCoordinator
    private let repository: UsersRepository
    
    init(repository: UsersRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func fillUsers() {
        repository.getUsers {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .success(let fetchedUsers):
                self.users = fetchedUsers
            }
        }
    }
    
    func didTapAlbums(with user: User) {
        coordinator.showAlbumsOf(user: user)
    }
    
    func didTapPosts(with user: User) {
        coordinator.showPostsOf(user: user)
    }
}
