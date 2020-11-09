//
//  LoginViewController.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit
import Foundation

class LoginViewController: UIViewController,Storyboarded{
    var coordinator: MainCoordinator?
    var webSocketHandler:WebSocketConnector?
    @IBOutlet weak var loginButton:UIButton?
    @IBOutlet weak var titleLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton?.isMultipleTouchEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        WebSocketDataHandler.add(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        WebSocketDataHandler.remove(listener:self)
    }
    
    @IBAction func loginButtonClicked() {
        //webSocketHandler?.setupConnection()
        webSocketHandler?.connect()
    }

}
extension LoginViewController:LoginResponseListener {
    func loginSuccess() {
        coordinator?.showHomeViewController(webSocketHandler:webSocketHandler!)
    }
    func handleError() {
        //display alert message
        
    }
}
