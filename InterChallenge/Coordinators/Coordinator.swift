//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import UIKit.UINavigationController
import UIKit.UIImage

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

//protocol AlbumCoordinator: AnyObject, Coordinator {
//    func showAlbumsOf(user: User)
//}
//
//protocol PostCoordinator: AnyObject, Coordinator {
//    func showPostsOf(user: User)
//}
//
//protocol CommentCoordinator: AnyObject, Coordinator {
//    func showCommentsIn(post: Post, ofUser user: User)
//}
//
//protocol PhotosListCoordinator: AnyObject, Coordinator {
//    func showPhotosIn(album: Album, ofUser user: User)
//}
//
//protocol PhotoCoordinator: AnyObject, Coordinator {
//    func showDetailsOf(photo: Photo, showingImage image: UIImage)
//}
