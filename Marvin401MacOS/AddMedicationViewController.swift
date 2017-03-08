//
//  AddMedicationViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 3/8/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation
import Cocoa

class AddMedicationViewController: NSViewController {
    
    @IBOutlet weak var medicineName: NSTextField!
    @IBOutlet weak var datePicker: NSDatePicker!
    let medicationScreenVC = MedicationScreenViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func AddMedication(_ sender: NSButton) {
        
        medicationScreenVC.addToTable()
    }
    
}
