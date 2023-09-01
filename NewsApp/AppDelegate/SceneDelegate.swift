//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by İsmail Palalı on 26.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         guard let windowScene = (scene as? UIWindowScene) else { return }
         let window = UIWindow(windowScene: windowScene)
         let viewController = LaunchScreenViewController()
         let navigationController = UINavigationController(rootViewController: viewController)
         window.rootViewController = navigationController
         window.makeKeyAndVisible()
         self.window = window
    }
}
