//
//  Constants.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

class Constants: NSObject {
   
    struct loginStrings {
        static let loginKey = "login"
        static let authRequiredResponse = "auth_required"
        static let authSuccessfulResponse = "auth_ok"
        static let authOkResponse = "auth_ok"
        static let baseURL = "one.monmars5.com"
        static let webSocketURL:String = "wss://" + baseURL + "/api/websocket"
        static let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhY2FlZmM4ZDZmYjQ0YTgyYWY2ZTkyMzlmMDNmMzk3NiIsImlhdCI6MTYwNDA3NDk1MiwiZXhwIjoxOTE5NDM0OTUyfQ.NiDL4pI48CcGVVA8rPnMo51vzhRDS6brFc9wA0AuSGI"
        static let authSendRequestDict:[String:String] = ["type":"auth", "access_token":accessToken]
    }
}
