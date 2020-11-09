//
//  HomeViewController.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    var homeViewModel:HomeViewModel? = nil
    var coordinator: MainCoordinator?
    @IBOutlet weak var deviceListCollectionView:IOTDevicesCollectionView?
    @IBOutlet weak var climateDataDisplayView:ClimateDataDisplayView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel?.listIOTDevices()
        
        self.climateDataDisplayView?.isHidden = true
        self.deviceListCollectionView?.setup(viewModel:homeViewModel!)
        deviceListCollectionView?.btnTapActionOnCellSelection = { [weak self] index in
            let str = self?.homeViewModel?.nameAtIndex(index)
            switch str {
            case let value where ((value?.contains("Light")) != nil) : fallthrough
            case let value where ((value?.contains("Climate")) != nil):fallthrough //"Climate": fallthrough
            case let value where ((value?.contains("Lock")) != nil):
            self?.climateDataDisplayView?.isHidden = false
            self?.view.bringSubviewToFront((self?.climateDataDisplayView!)!)
                let dict = self?.homeViewModel?.valueAtIndex(index: index)

                self?.climateDataDisplayView?.callOnDeviceStateChange(index:index, viewModel:(self?.homeViewModel!)!, dict:dict!)
                
            default: 
                self?.climateDataDisplayView?.hideAll()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        WebSocketDataHandler.add(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        WebSocketDataHandler.remove(listener:self)
    }


}

extension HomeViewController:SocketResponseListener {
    func logout() {
        //TODO:
    }
    
    func loginSuccess() {
    }
    
    func handleError() {
        //TODO:
    }
    
    func listOfDevices(arrayOfDevices: [AnyObject]) {
        self.homeViewModel?.setDeviceList(arrayOfDevices: arrayOfDevices)
        self.deviceListCollectionView?.reloadUI()

    }
    
    
}

