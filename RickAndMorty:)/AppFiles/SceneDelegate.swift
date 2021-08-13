//
//  SceneDelegate.swift
//  RickAndMorty:)
//
//  Created by Антон on 09.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let vc = MainViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

