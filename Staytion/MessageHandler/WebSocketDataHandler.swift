//
//  WebSocketDataHandler.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

/*protocol socketResponseProtocol {
 func loginSuccessfull()
 }*/

protocol UpdateModelListener: class {
    func updateModel(message:String)
    
}

protocol LoginResponseListener:class {
    func loginSuccess()
    func handleError()
}

protocol SocketResponseListener:LoginResponseListener {
    func logout()
    func listOfDevices(arrayOfDevices:[AnyObject])
}

class WebSocketDataHandler {
    
    private static var updateModelListener:UpdateModelListener?
    private static var socketResponseListener:SocketResponseListener?
    private static var loginResponseListener:LoginResponseListener?
    
    class func loginSuccess() {
        loginResponseListener?.loginSuccess()
    }
    
    class func responseWithAllDeviceList(jsonArray:[AnyObject]) {
        _ = [String:AnyObject]()
        
        socketResponseListener?.listOfDevices(arrayOfDevices: jsonArray)
    }
    
    class func add(listener: SocketResponseListener) {
        weak var weakListener = listener
        socketResponseListener = weakListener
    }
    
    class func remove(listener: SocketResponseListener) {
        socketResponseListener = nil
    }
    
    class func add(listener: LoginResponseListener) {
        weak var weakListener = listener
        loginResponseListener = weakListener
    }
    
    class func remove(listener: LoginResponseListener) {
        loginResponseListener = nil
    }
}
