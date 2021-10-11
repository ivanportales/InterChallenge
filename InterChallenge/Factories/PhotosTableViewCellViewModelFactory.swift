//
//  PhotosTableViewCellViewModelFactory.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 11/10/21.
//

import Foundation

// MARK: - Factory to create the view models of PhotoTableCell
protocol PhotosTableViewCellViewModelFactory {
    func makeViewModelWith(photo: Photo, and repository: PhotosRepository) -> PhotoTableCellViewModel
}

// MARK: - Default implementation of factory method
extension PhotosTableViewCellViewModelFactory {
    func makeViewModelWith(photo: Photo, and repository: PhotosRepository) -> PhotoTableCellViewModel {
        PhotoTableCellViewModel(photo: photo, repository: repository)
    }
}
