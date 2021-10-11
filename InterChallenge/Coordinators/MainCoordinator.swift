//
//  MainCoordinator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import UIKit.UINavigationController

// MARK: - Concrete implementation of coordinator to controll the floww of the app
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var mainFactory: AppMainFactory
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, mainFactory: AppMainFactory) {
        self.navigationController = navigationController
        self.mainFactory = mainFactory
    }
    
    func start() {
        let firstVC = mainFactory.makeUsersTableViewControllerWith(coordinator: self)
        navigationController.pushViewController(firstVC, animated: false)
    }
}

extension MainCoordinator {
    func showAlbumsOf(user: User) {
        let destinationVC = mainFactory.makeAlbumsTableViewControllerWith(user: user, and: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPostsOf(user: User) {
        let destinationVC = mainFactory.makePostsTableViewControllerWith(user: user, and: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showCommentsIn(post: Post, ofUser user: User) {
        let destinationVC = mainFactory.makeCommentTableViewControllerWith(post: post, ofUser: user, and: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showPhotosIn(album: Album, ofUser user: User) {
        let destinationVC = mainFactory.makePhotosTableViewControllerWith(album: album, ofUser: user, and: self)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}

extension MainCoordinator {
    func showDetailsOf(photo: Photo, showingImage image: UIImage) {
        let destinationVC = mainFactory.makePhotoDetailViewController(photo: photo, showingImage: image)
        navigationController.pushViewController(destinationVC, animated: true)
    }
}
