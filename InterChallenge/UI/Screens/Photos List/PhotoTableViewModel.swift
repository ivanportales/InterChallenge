//
//  PhotoTableViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 07/10/21.
//

import Foundation
import UIKit.UIImage
import Combine

class PhotoTableViewModel: ObservableObject {
    // MARK: - Bindings properties
    @Published private(set) var photos = [Photo]()
    @Published private(set) var errorMessage: String = ""
    
    // MARK: - Private properties
    private let coordinator: MainCoordinator
    private let user: User
    private let album: Album
    private let repository: PhotosRepository
    private let factory: PhotosTableViewCellViewModelFactory

    init(user: User, album: Album, repository: PhotosRepository, factory: PhotosTableViewCellViewModelFactory,coordinator: MainCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
        self.factory = factory
        self.album = album
        self.user = user
    }
    
    func fillPhotos() {
        repository.getPhotosFrom(albumId: album.id) { result in
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
            }
        }
    }
    
    func getImageFrom(urlString: String, completion: @escaping (Result<Data, RepositoryError>) -> ()) {
        repository.getImageDataOf(stringUrl: urlString, completion: completion)
    }
    
    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
        coordinator.showDetailsOf(photo: photo, showingImage: image)
    }
    
    func makeTableCellViewModelWith(photo: Photo) -> PhotoTableCellViewModel{
        self.factory.makeViewModelWith(photo: photo, and: self.repository)
    }
}

// MARK: - Computed properties
extension PhotoTableViewModel {
    var navigationBarTitle: String {
        "Fotos de \(user.name)"
    }
}
