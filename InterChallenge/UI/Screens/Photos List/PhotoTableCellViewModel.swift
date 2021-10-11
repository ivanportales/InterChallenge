//
//  PhotoTableCellViewModel.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 11/10/21.
//

import Foundation
import UIKit.UIImage

class PhotoTableCellViewModel {
    // MARK: - Bindings properties
    @Published private(set) var image = UIImageWithUrl()
    
    // MARK: - Private properties
    private weak var repository: PhotosRepository?
    let photo: Photo
    
    init(photo: Photo, repository: PhotosRepository) {
        self.photo = photo
        self.repository = repository
    }

    func getPhotoImsgeThumbnailurl() {
        guard let repository = repository else { return }
        self.image.imageUrl = self.photo.thumbnailUrl
        repository.getImageDataOf(stringUrl: photo.thumbnailUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_):
                self.image = UIImageWithUrl()
            case .success(let data):
                guard let newImage = UIImageWithUrl(data: data) else {
                    self.image = UIImageWithUrl()
                    return
                }
                newImage.imageUrl = self.photo.thumbnailUrl
                self.image = newImage
            }
        }
    }
}
