//
//  SceneDelegate.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var delegates: [UIWindowSceneDelegate] = []

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        registerDelegates()
        delegates.forEach {
            $0.scene?(scene, willConnectTo: session, options: connectionOptions)
        }
    }
    
    private func registerDelegates() {
        let routerDelegate = RouterSceneDelegate()
        [routerDelegate]
            .forEach { delegates.append($0) }
    }
}
