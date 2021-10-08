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
    @Published private(set) var photos = [Photo]()
    weak var coordinator: MainCoordinator?
    var repository: PhotosRepository
    var user: User
    var album: Album
    
    var navigationBarTitle: String {
        user.name
    }
    
    init(user: User, album: Album, repository: PhotosRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
        self.album = album
        self.user = user
    }
    
    func fillPhotos() {
        repository.getPhotosFrom(albumId: album.id) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
            }
        }
    }
    
    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
        self.coordinator?.showDetailsOf(photo: photo, showingImage: image)
    }
}
