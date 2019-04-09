//
//  ViewController.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var statePickerView: UIPickerView!
    @IBOutlet var parkPickerView: UIPickerView!
    
    var statePicker: StatePicker?
    var parkPicker: ParkPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePicker = StatePicker(states: States.stateNames)
        statePickerView.dataSource = statePicker
        statePickerView.delegate = statePicker
        
        parkPicker = ParkPicker()
        parkPickerView.dataSource = parkPicker
        parkPickerView.delegate = parkPicker
        
    }

    @IBAction func showParkButtonTapped(_ sender: Any) {
        let row = statePickerView.selectedRow(inComponent: 0)
        let stateName = statePicker!.stateFor(row: row)
        let stateAbbr = States.stateAbbreviation(for: stateName)
        getParks(for: stateAbbr!)
    }
    
    func getParks(for state: String) {
        
        let service = NationalParksService()
        service.fetchParks(for: state) { (parks: [NationalPark]?, error: Error?) -> Void in
            
            if let parks = parks {
                self.parkPicker!.parks = parks
                DispatchQueue.main.async {
                    self.parkPickerView.reloadAllComponents()
                    self.parkPickerView.selectRow(0, inComponent: 0, animated: true)
                }
            }
        }
    }
    
}

