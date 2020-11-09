//
//  ClimateDataDisplayView.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 08/11/20.
//

import UIKit

class ClimateDataDisplayView: UIView {
    
    @IBOutlet weak var showChangeInLabel:UILabel!
    @IBOutlet weak var displaytitleForSlider:UILabel!
    @IBOutlet weak var changeSlider:UISlider!
    @IBOutlet weak var deviceTitle:UILabel!
    
    @IBOutlet weak var onOffSwitch:UISwitch!
    
    var index = 0
    var viewModel:HomeViewModel?
    var entity_id:String = ""
    var dict:[String:AnyObject] = [:]
    
    @IBAction func switchToggled(sender:AnyObject) {
        let str = WebSocketMessageBuilder.sendDeviceTurnOnOffStatus(boolValue:sender.isOn, entity_id:self.entity_id)
        self.viewModel?.send(message: str)
    }

    @IBAction func brightnessVaried(sender:UISlider) {
        showChangeInLabel.text = String(format: "%.2f", Float(sender.value))
        let floatValue = Float(sender.value)
        //let str = WebSocketMessageBuilder.sendDeviceValueChangedStatus(value:floatValue, entity_id:self.entity_id)
       // self.viewModel?.send(message: str)
        
    }
    
    func callOnDeviceStateChange(index:Int, viewModel:HomeViewModel, dict:[String:AnyObject]) {
        self.dict = dict
        self.viewModel = viewModel
        guard let str = dict["entity_id"] as? String else { return  }
        self.entity_id = str
        self.deviceTitle.text = self.viewModel?.deviceTitle(titleStr: entity_id)
        switch(str) {
        case let value where value.contains("light"):
            self.enableLightDeviceUI()
        case let value where value.contains("lock"):
            self.enableLockDeviceUI()
        case let value where value.contains("climate"):
            self.enableClimateDeviceUI()
            
        default:
            self.hideAll()
        }
        
    }
    
    func enableLightDeviceUI() {
        self.changeSlider.isHidden = false
        self.showChangeInLabel.isHidden = false
        self.displaytitleForSlider.text = "Change brightness"
        self.displaytitleForSlider.isHidden = false
        let state:String = dict["state"] as! String
        changeSlider.minimumValue = 0.0
        changeSlider.maximumValue = 255.0
        if(state == "turn_on" || state == "on" ){
            self.onOffSwitch.setOn(true, animated: true)
        }
        else {
            self.onOffSwitch.setOn(false, animated: true)

        }
        let attributes:[String:Any] = dict["attributes"] as! [String : Any]
        let tempValue = attributes["brightness"] as? Int
        self.showChangeInLabel.text = String(tempValue ?? 0)
        self.changeSlider.setValue(Float(tempValue ?? 0), animated: true)

    }
    
    func enableLockDeviceUI() {
        self.changeSlider.isHidden = true
        self.showChangeInLabel.isHidden = true
        self.onOffSwitch.isHidden = false
        self.displaytitleForSlider.isHidden = true
        let state:String = dict["state"] as! String
        if(state == "turn_on" || state == "on" ){
            self.onOffSwitch.setOn(true, animated: true)
        }
        else {
            self.onOffSwitch.setOn(false, animated: true)

        }

    }
    
    func enableClimateDeviceUI() {
        self.onOffSwitch.isHidden = false

        self.changeSlider.isHidden = false
        self.showChangeInLabel.isHidden = false
        self.displaytitleForSlider.isHidden = false
        self.displaytitleForSlider.text = "Change temperature"
        let attributes:[String:Any] = dict["attributes"] as! [String : Any]
        changeSlider.minimumValue = attributes["min_temp"] as? Float ?? 0
        changeSlider.maximumValue = attributes["max_temp"] as? Float ?? 0
        let state:String = dict["state"] as! String
        if(state == "turn_on" || state == "on" ){
            self.onOffSwitch.setOn(true, animated: true)
        }
        else {
            self.onOffSwitch.setOn(false, animated: true)

        }
        let tempValue = attributes["temperature"] as? Int
        self.showChangeInLabel.text = String(tempValue ?? 0)
        self.changeSlider.setValue(Float(tempValue ?? 0), animated: true)

    }
    
    func hideAll() {
        self.changeSlider.isHidden = true
        self.showChangeInLabel.isHidden = true
        self.displaytitleForSlider.isHidden = true
        self.onOffSwitch.setOn(false, animated: true)
        self.onOffSwitch.isHidden = true

    }
    
}
