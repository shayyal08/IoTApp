//
//  HomeViewModel.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import Foundation


class HomeViewModel {
    private var webSocketHandler:WebSocketConnector
    private var deviceModelInfo:IOTDeviceInfo = IOTDeviceInfo()
    //static var listOfDevices:[AnyObject] = []
    init(webSocketHandler:WebSocketConnector) {
        self.webSocketHandler = webSocketHandler
    }
    
    func listIOTDevices() {
        webSocketHandler.send(message: WebSocketMessageBuilder.buildMessageToRequestDevices())
    }
    
    func send(message:String) {
        webSocketHandler.send(message: message)
    }
    
     func setDeviceList(arrayOfDevices:[AnyObject]) {
        self.deviceModelInfo.setDeviceList(deviceList:arrayOfDevices)
     }
        
    func listOfDevicesCount() ->Int {
        return self.deviceModelInfo.deviceCount()
    }
    
    func valueAtIndex(index:Int) -> [String:AnyObject] {
        return self.deviceModelInfo.objectAtIndex(index)
    }
    
    func nameAtIndex(_ index:Int)->String {
        if(index < deviceModelInfo.deviceCount()  ) {
            let dict = deviceModelInfo.objectAtIndex(index)
            guard let str = dict["entity_id"] as? String else { return "" }
            
            return self.deviceTitle(titleStr:str)
     
        }
        return ""
    
    }
    
    func deviceTitle(titleStr:String)->String {
        var str = ""
        switch  titleStr {
            case "sun.sun":  str =  "Sun"
        case "zone.home":  str = "Zone"
        case "binary_sensor.updater": str = "Sensor Update"
        case "climate.heatpump": str = "Climate Heatpump"
        case "light.bed_light": str = "Bed-Light"
        case "light.ceiling_lights": str = "Ceiling Lights"
        case "light.kitchen_lights": str = "Kitchen Lights"
        case "lock.front_door": str = "Front Door Lock"
        case "lock.kitchen_door": str = "Kitchen Lock"
        case "lock.openable_lock": str = "Openable Lock"
        case "weather.home": str = "Weather"
        case "persistent_notification.http_login": str = "login"
        default:
            return("")
        }
        return str
    }
}
