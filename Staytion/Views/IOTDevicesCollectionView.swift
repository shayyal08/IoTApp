//
//  IOTDevicesCollectionView.swift
//  Staytion
//
//  Created by Shilpa Hayyal on 07/11/20.
//

import UIKit

class IOTDevicesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    var viewModel:HomeViewModel? = nil
    var btnTapActionOnCellSelection : ((_ index:Int)->())?
    
    func setup(viewModel:HomeViewModel) {
        self.delegate = self
        self.dataSource = self
        self.viewModel = viewModel
    }
    
    func reloadUI() {
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.viewModel?.listOfDevicesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:DeviceCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DeviceCollectionViewCell
            cell.deviceName.text = self.viewModel?.nameAtIndex(indexPath.row)
            cell.tag = indexPath.row

            return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    //UICollectionViewDelegateFlowLayout api
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.size.width-28) / 3 , height:140)
    }
    
    final public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        btnTapActionOnCellSelection?(indexPath.row)
    }
    
    
}
