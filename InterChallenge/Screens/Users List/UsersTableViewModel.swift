//
//  UsersTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import Combine

class UsersTableViewModel: ObservableObject {
    private weak var coordinator: MainCoordinator?
    private let repository: UsersRepository
    @Published private(set) var users = [User]()
    
    init(repository: UsersRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func fillUsers() {
        repository.getUsers {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
//                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//                    alert.dismiss(animated: true)
//                }))
//                self.present(alert, animated: true)
            case .success(let fetchedUsers):
                guard let self = self else { return }
                self.users = fetchedUsers
            }
        }
    }
    
    // passar isso pra viewModel da celula da tableview
    func didTapAlbums(with user: User) {
        coordinator?.showAlbumsOf(user: user)
    }
    
    func didTapPosts(with user: User) {
        coordinator?.showPostsOf(user: user)
    }
}

