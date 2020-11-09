//
//  IOTDeviceInfo.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import Foundation

enum domainType {
    case climate
    case lock
    case light
}

enum lightService {
    case turn_on
    case turn_off
}
enum lockService {
    case lock
    case unlock
}

protocol genericServiceData:Codable {
    var entity_id:String { get}
    var last_changed:String { get}
    var last_updated:String { get }
    var context:Context { get }
    var state:String { get }
}

struct Context:Codable {
    let id:String
    var parent_id:String?
    let user_id:String
}

struct DoorLock:genericServiceData, Codable {
    var entity_id: String
    
    var last_changed: String
    
    var last_updated: String
    
    var context: Context
    
    var state: String
    
    let attributes:DoorLockAttributes
}

struct DoorLockAttributes:Codable {
    let friendly_name:String
    let supported_features:Int?
}

struct climateServiceData:genericServiceData,Codable {
    var friendly_name: String
    
    var last_changed: String
    
    var last_updated: String
    
    var context: Context
    
    var entity_id: String
    let attributes: climateAttributes
    let state:String
    
}

struct climateAttributes:Codable {
    var temperature:Int
    let hvac_modes:[String]
    let min_temp:Int
    let max_temp:Int
    let current_temperature:Int
    let hvac_action:String
    var supported_features:Int
}

struct lightServiceData:genericServiceData {
    var friendly_name: String
    
    var last_changed: String
    
    var last_updated: String
    
    var context: Context
    
    var entity_id: String
    var brightness:Int
    let state:String
    let attributes:LightAttributes
}

struct LightAttributes:Codable {
    let min_mireds:Int
    let max_mireds:Int
    let brightness:Int
    let hs_color:[Int]?
    let rgb_color:[Int]?
    let xy_color:[Double]?
    let white_value:String
    let supported_features:Int
    let color_temp:Int?
    let effect:String?
    let effect_list:[String]?
    
}

struct binarySensor:Codable,genericServiceData {
    var entity_id: String
    
    var last_changed: String
    
    var last_updated: String
    
    var context: Context
    
    var state: String
    
    var attributes = ["friendly_name" : "Updater"]
}

struct SendDeviceInfo:Codable {
 let id:Int
 let type:String
 let domain: String
 let service:String
 let service_data:[String:String]
 }

class IOTDeviceInfo {
    private var listOfDevices:[AnyObject] = [AnyObject]()
    private var lightDevices:[lightServiceData] = []
    private var climateDevice:climateServiceData?
    private var lockDevices:[DoorLock] = []
    //TODO:
    //convert json dict into climate, light, lock objects to display in UI through ViewModel.TODO: Not used yet in the UI
    func getDeviceInfoAt(index:Int) {
        if(index < listOfDevices.count) {
            var data:Data = Data()
            let dict = listOfDevices[index]
            if let str = dict["entity_id"] as? String {
                
                do {
                    data = try JSONSerialization.data(withJSONObject: dict, options:[])
                } catch  {
                    print("error")
                    return
                }
                let decoder = JSONDecoder()
                
                
                switch str {
                case let str where str.contains("light"):
                    
                    do {
                        let device = try decoder.decode(lightServiceData.self, from: data)
                        self.lightDevices.append(device)
                        print(device)
                        //self.listOfDevices.remove(at: index)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case let value where value.contains("climate"):
                    do {
                        let device = try decoder.decode(climateServiceData.self, from: data)
                        self.climateDevice = device
                        print(device)
                        //self.listOfDevices.remove(at: index)
                    } catch {
                        print(error.localizedDescription)
                    }
                    break
                case let value where value.contains("lock"):
                    do {
                        let device = try decoder.decode(DoorLock.self, from: data)
                        self.lockDevices.append(device)
                        print(device)
                        //self.listOfDevices.remove(at: index)
                    } catch {
                        print(error.localizedDescription)
                    }
                    break
                default: break
                }
            }
        }
    }
    
    func setDeviceList(deviceList:[AnyObject]) {
        listOfDevices.removeAll()
        listOfDevices = deviceList
        self.filter()
    }
    
    func deviceCount() -> Int {
        return self.listOfDevices.count
    }
    
    func objectAtIndex(_ index:Int) ->[String:AnyObject] {
        if(index < listOfDevices.count) {
            return listOfDevices[index] as? [String : AnyObject] ?? Dictionary()
        }
        return Dictionary()
    }
    
    private func filter() {
        var index = 0
        while index <= listOfDevices.count - 1  {
            let dict = listOfDevices[index] as? [String:AnyObject]
            guard let str = dict?["entity_id"] as? String else { return }
            self.getDeviceInfoAt(index: index)
            if(str.hasPrefix("persistent") || str.hasPrefix("person")) {
                listOfDevices.remove(at: index )
            }
            index = index + 1

        }
    }
}
