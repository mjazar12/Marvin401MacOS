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
    

    var medicationEntered = Medication();
    var medScreen : MedicationScreenViewController!
    
    @IBOutlet weak var medicationName: NSTextField!
    @IBOutlet weak var prescriptionDate: NSDatePicker!
    
    @IBOutlet weak var medName: NSTextField!
    var completionHandler: ((_ med: Medication) -> Void)? //completion handler to store medication obj.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    
    @IBAction func addMedication(_ sender: NSButton) {
        print(medName.stringValue)
        medicationEntered.addName(medName: medName.stringValue) //add name to medication object
//        performSegue(withIdentifier: "AddMedicationSegue", sender: self)
//
        //medScreen.addToTable(medication: Medication(medName: medicationName.stringValue, takeDate: prescriptionDate.stringValue))
        self.completionHandler!(medicationEntered) //add medication to completion handler
    }
    
    /*override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddMedicationSegue") {
            let medicationScreenVC = segue.destinationController as! MedicationScreenViewController;
            medicationScreenVC.medicationAdded = medicationEntered
        }
    }*/
}
