//
//  WebSocketMessageParser.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import Foundation

class WebSocketMessageParser: NSObject {

    //parse data received from webSocket
    class func parseSocketResponse(jsonString:String) -> [String:AnyObject]? {
            if let data = jsonString.data(using: .utf8) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                    print(json?.description ?? "")
                    mapToRequestMessage(jsonDict:json ?? [String:AnyObject]())
                    return json
                } catch {
                    print("Something went wrong")
                }
            }
            return nil
        }
    
    //map request and response messages based on id
    class func mapToRequestMessage(jsonDict:[String:AnyObject]) {
        let identifier:Int = jsonDict["id"] as? Int ?? 0
        switch identifier {
        case 16:
            let jsonArray:[AnyObject] = (jsonDict["result"] as? [AnyObject])!
            WebSocketDataHandler.responseWithAllDeviceList(jsonArray:jsonArray)
            break //load devices
        case 17: break //save light
        case 18: break //save temperature
        case 19: break //save door lock info
        default:
            //do nothing
        print("no matching response received")
        }
    }
}
