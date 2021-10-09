//
//  MainCoordinator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import UIKit.UINavigationController

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = UsersTableViewModel(repository: WebUserRepository(), coordinator: self)
        let firstVC = UsersTableViewController(viewModel: viewModel)
        navigationController.pushViewController(firstVC, animated: false)
    }
}

extension MainCoordinator {
    func showAlbumsOf(user: User) {
        let viewModel = AlbumTableViewModel(user: user, repository: WebAlbumsRepository(), coordinator: self)
        let destinationVC = AlbumTableViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPostsOf(user: User) {
        let viewModel = PostsTableViewModel(user: user, repository: WebPostsRepository(), coordinator: self)
        let destinationVC = PostTableViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showCommentsIn(post: Post, ofUser user: User) {
        let viewModel = CommentTableViewModel(user: user, post: post, repository: WebCommentRepository())
        let destinationVC = CommentTableViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPhotosIn(album: Album, ofUser user: User) {
        let repository = PhotosRepositoryCacheDecorator(cache: PhotoImageCache(), repository:  WebPhotoRepository())
        let viewModel = PhotoTableViewModel(user: user, album: album, repository: repository, coordinator: self)
        let destinationVC = PhotoTableViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
        let destinationVC = PhotoDetailsViewController(image: image, photo: photo)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}
