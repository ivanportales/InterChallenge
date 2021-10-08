//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import UIKit.UINavigationController

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
