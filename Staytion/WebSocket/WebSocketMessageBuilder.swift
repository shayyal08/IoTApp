//
//  WebSocketMessageBuilder.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

class WebSocketMessageBuilder: NSObject {
    
    class func authRequestMessage()-> String {
        return jsonStringForm(from:Constants.loginStrings.authSendRequestDict)
    }
    
    class func buildMessageToRequestDevices() ->String {
        let requestMessage = ["id":"16", "type":"get_states"]
        return jsonStringForm(from:requestMessage)
    }
    
    class func jsonStringForm(from dict:[String:String]) -> String {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dict) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            }
        }
        return ""
    }
    
    class func messageForm(deviceRequestMessage:SendDeviceInfo) ->String{
        if let json_data = try? JSONEncoder().encode(deviceRequestMessage)
        {
            if let jsonString = String(data: json_data, encoding: .utf8) {
                print(jsonString)
                return jsonString
            }
        }
        return ""
    }
    
    class func sendDeviceTurnOnOffStatus(boolValue:Bool, entity_id:String) ->String {
        var strValue:String
        if(boolValue) {
            strValue = "turn_on"
        } else {
            strValue = "turn_off"
        }
        switch(entity_id) {
        case let value where value.contains("light"):
            let sendMessage = SendDeviceInfo(id: 19, type: "call_service", domain: "light", service: strValue, service_data: ["entity_id":entity_id] )
            return WebSocketMessageBuilder.messageForm(deviceRequestMessage: sendMessage)
        case let value where value.contains("lock"):
            var lockValue:String
            if(boolValue) {
                lockValue = "lock"
            } else {
                lockValue = "unlock"
            }
            let sendMessage = SendDeviceInfo(id: 20, type: "call_service", domain: "lock", service: lockValue, service_data: ["entity_id":entity_id] )
            return WebSocketMessageBuilder.messageForm(deviceRequestMessage: sendMessage)
        case let value where value.contains("climate"):
            
            let sendMessage = SendDeviceInfo(id: 21, type: "call_service", domain: "climate", service: strValue, service_data: ["entity_id":entity_id] )
            return WebSocketMessageBuilder.messageForm(deviceRequestMessage: sendMessage)
    
        default:
            print("")
        }
        return("")
        
    }
    
  /*  class func sendDeviceValueChangedStatus(tempValue:Float, entity_id:String) -> String {
      switch(entity_id) {
        case let value where value.contains("light"):
            let dictionary:[String:Any] = ["entity_id":entity_id, "brightness": tempValue]
            let sendMessage = SendDeviceInfo(id: 25, type: "call_service", domain: "light", service: "turn_on", service_data:dictionary  )
            return WebSocketMessageBuilder.messageForm(deviceRequestMessage: sendMessage)
        case let value where value.contains("climate"):
            let dictinary:[String:Any] = ["entity_id":entity_id, "temperature": tempValue]
            let sendMessage = SendDeviceInfo(id: 24, type: "call_service", domain: "climate", service: "set_temperature", service_data: dictionary )
            return WebSocketMessageBuilder.messageForm(deviceRequestMessage: sendMessage)
        default:
            print("")
        }
        return("")
    }*/
    
}
