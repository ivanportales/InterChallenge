//
//  AppMainFactory.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 11/10/21.
//

import Foundation
import UIKit.UIViewController

// MARK: - Declaration of the app factory
class AppMainFactory {
    func makeMainCoordinatorWith(navigationController: UINavigationController) -> MainCoordinator {
        MainCoordinator(navigationController: navigationController, mainFactory: self)
    }
}

// MARK: - Factory extensions to each ViewController
extension AppMainFactory {
    func makeUsersTableViewControllerWith(coordinator: MainCoordinator) -> UIViewController {
        let viewModel = UsersTableViewModel(repository: WebUserRepository(), coordinator: coordinator)
        let viewController = UsersTableViewController(viewModel: viewModel)
        return viewController
    }
}

extension AppMainFactory {
    func makeAlbumsTableViewControllerWith(user: User, and coordinator: MainCoordinator) -> UIViewController {
        let viewModel = AlbumTableViewModel(user: user, repository: WebAlbumsRepository(), coordinator: coordinator)
        let viewController = AlbumTableViewController(viewModel: viewModel)
       return viewController
    }
}

extension AppMainFactory {
    func makePostsTableViewControllerWith(user: User, and coordinator: MainCoordinator) -> UIViewController {
        let viewModel = PostsTableViewModel(user: user, repository: WebPostsRepository(), coordinator: coordinator)
        let viewController = PostTableViewController(viewModel: viewModel)
        return viewController
    }
}

extension AppMainFactory {
    func makeCommentTableViewControllerWith(post: Post, ofUser user: User, and coordinator: MainCoordinator) -> UIViewController {
        let viewModel = CommentTableViewModel(user: user, post: post, repository: WebCommentRepository())
        let viewController = CommentTableViewController(viewModel: viewModel)
        return viewController
    }
}

extension AppMainFactory {
    func makePhotosTableViewControllerWith(album: Album, ofUser user: User, and coordinator: MainCoordinator) -> UIViewController {
        let repository = PhotosRepositoryCacheDecorator(cache: PhotoImageCache(), repository:  WebPhotoRepository())
        let viewModel = PhotoTableViewModel(user: user, album: album, repository: repository, coordinator: coordinator)
        let viewController = PhotoTableViewController(viewModel: viewModel)
        return viewController
    }
}

extension AppMainFactory {
    func makePhotoDetailViewController(photo: Photo, showingImage image: UIImage) -> UIViewController {
        PhotoDetailsViewController(image: image, photo: photo)
    }
}

extension AppMainFactory: PhotosTableViewCellViewModelFactory {}
