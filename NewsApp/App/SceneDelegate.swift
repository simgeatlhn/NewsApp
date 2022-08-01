//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let  windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let mainController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}


