//
//  PhotosTableViewCellViewModelFactory.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 11/10/21.
//

import Foundation

protocol PhotosTableViewCellViewModelFactory {
    func makeViewModelWith(photo: Photo, and repository: PhotosRepository) -> PhotoTableCellViewModel
}

extension PhotosTableViewCellViewModelFactory {
    func makeViewModelWith(photo: Photo, and repository: PhotosRepository) -> PhotoTableCellViewModel {
        PhotoTableCellViewModel(photo: photo, repository: repository)
    }
}
