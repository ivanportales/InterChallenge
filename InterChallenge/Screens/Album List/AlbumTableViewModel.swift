//
//  AlbumTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 07/10/21.
//

import Foundation

class AlbumTableViewModel: ObservableObject {
    @Published private(set) var albums = [Album]()
    @Published private(set) var errorMessage: String = ""
    private let coordinator: MainCoordinator
    private let repository: AlbumsRepository
    private let user: User
    
    var navigationBarTitle: String {
        user.name
    }
    
    init(user: User, repository: AlbumsRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.user = user
        self.coordinator = coordinator
    }
    
    func fillAlbums() {
        repository.getAlbumsOf(userId: user.id) { result in
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .success(let fetchedAlbums):
                self.albums = fetchedAlbums
            }
        }
    }
    
    func showPhotosIn(album: Album) {
        coordinator.showPhotosIn(album: album, ofUser: user)
    }
}
