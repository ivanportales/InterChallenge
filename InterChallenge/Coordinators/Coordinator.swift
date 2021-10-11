//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 06/10/21.
//

import Foundation
import UIKit.UINavigationController

// MARK: - Coordinator protocol
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
