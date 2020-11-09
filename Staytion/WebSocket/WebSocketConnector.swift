//
//  WebSocketConnector.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 08/11/20.
//

import Foundation
import Starscream

class WebSocketConnector: NSObject, WebSocketDelegate {

    var socket : WebSocket!
    var isConnected = false
    let authMessage = WebSocketMessageBuilder.authRequestMessage()

    override init(){
        super.init()
        var request = URLRequest(url: URL(string: Constants.loginStrings.webSocketURL)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func connect() {
        socket.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            //isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            if(!isConnected) {
                self.login(message:string)
            }
            //parse string
            let dict = WebSocketMessageParser.parseSocketResponse(jsonString: string)
            print(dict ?? "")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error: error!)
        }
    }
    
    func handleError(error:Error) {
        socket.disconnect()
        isConnected = false
    }
    
    func login(message:String) {
        if (message.contains(Constants.loginStrings.authRequiredResponse)) {
            self.proceedFurtherWithToken()
        } else if(message.contains(Constants.loginStrings.authSuccessfulResponse)) {
            isConnected = true
            WebSocketDataHandler.loginSuccess()
            
        }
    }
    
    func proceedFurtherWithToken() {
        self.send(message:authMessage)
    }
    
    
    func send(message:String) {
        print("Send Message: \(message)")
        socket.write(string: message)
    }
    
    func disconnect() {
        socket.disconnect()
        isConnected = false
    }
}
