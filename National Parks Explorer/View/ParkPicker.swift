//
//  ParkPicker.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ParkPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var parks: [NationalPark] = []
    
    // from data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return parks.count
    }
    
    // from UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if parks.indices.contains(row) {
            return parks[row].fullName
        } else {
            return nil
        }
    }
    
    func parkFor(row: Int) -> NationalPark? {
        if parks.indices.contains(row) {
            return parks[row]
        } else {
            return nil
        }
    }
}
