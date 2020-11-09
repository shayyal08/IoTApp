//
//  MainCoordinator.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

class MainCoordinator {
    private var navigationController:UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.setNavigationBarHidden(true, animated: false)
        let webSocketHandler:WebSocketConnector = WebSocketConnector()
        let viewController = LoginViewController.instantiate()
        viewController.coordinator = self
        viewController.webSocketHandler = webSocketHandler
        self.navigationController.pushViewController(viewController, animated: false)
        
    }
    
    func showHomeViewController(webSocketHandler:WebSocketConnector) {
        let viewController = HomeViewController.instantiate()
        viewController.coordinator = self
        viewController.homeViewModel = HomeViewModel(webSocketHandler:webSocketHandler)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    
}
