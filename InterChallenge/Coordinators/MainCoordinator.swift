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
        let firstVC = UsersTableViewController(viewModel: UsersTableViewModel(repository: WebUserRepository(), coordinator: self))
        navigationController.pushViewController(firstVC, animated: false)
    }
}

extension MainCoordinator {
    func showAlbumsOf(user: User) {
        let destinationVC = AlbumTableViewController(user: user, repository: WebAlbumsRepository(), coordinator: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPostsOf(user: User) {
        let destinationVC = PostTableViewController(user: user, repository: WebPostsRepository(), coordinator: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showCommentsIn(post: Post, ofUser user: User) {
        let destinationVC = CommentTableViewController(user: user, post: post, repository: WebCommentRepository())
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPhotosIn(album: Album, ofUser user: User) {
        let destinationVC = PhotoTableViewController(user: user, album: album, repository: WebPhotoRepository(), coordinator: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
        let destinationVC = PhotoDetailsViewController(image: image, photo: photo)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

//
//extension MainCoordinator: AlbumCoordinator {
//    func showAlbumsOf(user: User) {
//        let destinationVC = AlbumTableViewController(user: user, repository: WebAlbumsRepository(), coordinator: self)
//        navigationController.pushViewController(destinationVC, animated: true)
//    }
//}
//
//extension MainCoordinator: PostCoordinator {
//    func showPostsOf(user: User) {
//        let destinationVC = PostTableViewController(user: user, repository: WebPostsRepository(), coordinator: self)
//        navigationController.pushViewController(destinationVC, animated: true)
//    }
//}
//
//extension MainCoordinator: CommentCoordinator {
//    func showCommentsIn(post: Post, ofUser user: User) {
//        let destinationVC = CommentTableViewController(user: user, post: post, repository: WebCommentRepository())
//        navigationController.pushViewController(destinationVC, animated: true)
//    }
//}
//
//extension MainCoordinator: PhotosListCoordinator {
//    func showPhotosIn(album: Album, ofUser user: User) {
//        let destinationVC = PhotoTableViewController(user: user, album: album, repository: WebPhotoRepository(), coordinator: self)
//        navigationController.pushViewController(destinationVC, animated: true)
//    }
//}
//
//extension MainCoordinator: PhotoCoordinator {
//    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
//        let destinationVC = PhotoDetailsViewController(image: image, photo: photo)
//        navigationController.pushViewController(destinationVC, animated: true)
//    }
//}
