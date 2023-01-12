//
//  SceneDelegate.swift
//  Timer - HW12
//
//  Created by Константин Киселёв on 13.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options
                connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let _ = ViewController()
        window = UIWindow(windowScene: windowsScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}

