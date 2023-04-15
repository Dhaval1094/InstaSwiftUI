//
//  RootCoordinator.swift
//  InstaUI
//
//  Created by iOS Developer on 14/04/23.
//

import Foundation
import SwiftUI
 
final class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    let navigationController: UINavigationController
    var root: UIViewController {
        return navigationController
    }
    static var shared: RootCoordinator {
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return RootCoordinator()
        }
        return scene.rootCoordinator
    }
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
    }
    func start() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
    }
}
