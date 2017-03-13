//
//  MedicationScreenViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 3/8/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation
import Cocoa

class MedicationScreenViewController: NSViewController {
    
 
    @IBOutlet weak var MedicationTable: NSTableView!
    @IBOutlet weak var Name: NSTextFieldCell!
    @IBOutlet weak var Date: NSTextFieldCell!
    
    var medicationLog = MedicationLog()
    let addMedicationVC = AddMedicationViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func addToTable() {
        let name = addMedicationVC.medicineName.stringValue
        let date = addMedicationVC.datePicker.stringValue
        var medicationEntered = Medication(medName: name, takeDate: date)
        medicationLog.addMedication(medication: medicationEntered) //add to log
        //Name.stringValue(medicationEntered.name)
        //Date.stringValue(medicationEntered.date)
    }
    
    
}

