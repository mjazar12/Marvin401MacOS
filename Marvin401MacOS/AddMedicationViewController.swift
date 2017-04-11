//
//  AddMedicationViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 3/8/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import SwiftyJSON

class AddMedicationViewController: NSViewController {
    

    @IBOutlet weak var prescriptionNumber: NSTextField!
    @IBOutlet weak var medDate: NSDatePicker!
    @IBOutlet weak var contentView: NSClipView!
    var medicationEntered = Medication();
    var medScreen : MedicationScreenViewController!
    
    @IBOutlet weak var medicationNameField: NSTextField!
    @IBOutlet weak var whatItsFor: NSTextField!
    @IBOutlet weak var dosage: NSTextField!
    @IBOutlet weak var idField: NSTextField!
    @IBOutlet weak var medicationName: NSTextField!
    @IBOutlet weak var prescriptionDate: NSDatePicker!
    @IBOutlet weak var dosageField: NSTextField!
    @IBOutlet weak var instructionsField: NSTextField!
    
    @IBOutlet weak var medName: NSTextField!
    var completionHandler: ((_ med: Medication) -> Void)? //completion handler to store medication obj.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.scroll(NSPoint(x:0, y:500))
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func openBarcode(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.begin { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                print(ViewController().scanImage(openPanel.urls[0].path))
                
                var str = ViewController().scanImage(openPanel.urls[0].path).components(separatedBy: "/").last
                str = (str?.components(separatedBy: "-")[0])! + "-" + (str?.components(separatedBy: "-")[1])!
                self.prescriptionNumber.stringValue = str!
                let url = "https://api.fda.gov/drug/label.json?search=openfda.product_ndc:%22" + str! + "%22&limit=100"
                print(url)
                Alamofire.request(url).responseJSON { (responseData) -> Void in
                    
                    let json = JSON(responseData.result.value!)
                    print(json["results"][0])
                    
                    if let name = json["results"][0]["openfda"]["brand_name"][0].string {
                        self.medicationNameField.stringValue = name
                    }
                    if let derscription = json["results"][0]["description"][0].string {
                        self.whatItsFor.stringValue = derscription
                    }
                    if let dosage = json["results"][0]["dosage_and_administration"][0].string {
                        self.dosageField.stringValue = dosage
                        self.instructionsField.stringValue = dosage
                    }
                }
                if result == NSFileHandlingPanelCancelButton {
                }
            }
        }
    }
    
    
    @IBAction func addMedication(_ sender: NSButton) {
        print(medDate.stringValue)
        medicationEntered.addName(medName: medName.stringValue) //add name to medication object
        medicationEntered.setDate(medDate:  medDate.stringValue)
        medicationEntered.setDosage(medDosage:  dosageField.stringValue)
        medicationEntered.setInstructions(medInstructions: instructionsField.stringValue)
        medicationEntered.setID(medID: prescriptionNumber.stringValue)
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
