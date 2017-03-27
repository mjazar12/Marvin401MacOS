//
//  MedicationScreenViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 3/8/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation
import Cocoa

class MedicationScreenViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var MedicationTable: NSTableView!
    @IBOutlet weak var Name: NSTextFieldCell!
    @IBOutlet weak var Date: NSTextFieldCell!
    
    var medicationLog = MedicationLog()
    let addMedicationVC = AddMedicationViewController()
    var medicationAdded = Medication()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationTable.delegate = self
        MedicationTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    /*func addToTable(medication : Medication) {
        medicationLog.addMedication(medication: medication) //add to log
        setRowValue(MedicationTable, name : "Name", row: 0)
    }*/
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return medicationLog.medicationList.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        if tableColumn == tableView.tableColumns[0] {
            if let cell = tableView.make(withIdentifier: "NameCellID", owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = self.medicationLog.medicationList[row].name
                return cell
            }
        }
        else if tableColumn == tableView.tableColumns[1] {
            if let cell = tableView.make(withIdentifier: "DateCellID", owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = self.medicationLog.medicationList[row].date
                return cell
            }
        }
    
        return nil
    }
    
    
    
    /*func setRowValue(_ tableView: NSTableView, name : String, row: Int) -> NSView? {
        
        
        let nameCell = MedicationTable.tableColumns[0].dataCell(forRow: row) as! NSTextFieldCell
        let nameCellView = nameCell.view
        
        
        nameCellView.textField?.stringValue = self.medicationLog.medicationList[row].name
        // TODO: add other attributes
        return nameCellView
    
    }*/
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddMedicationSegue") {
            
                        
            
            let addMedication = segue.destinationController as! AddMedicationViewController
            addMedication.completionHandler = { //completion handler that recieves medication object
                
                (med: Medication) in 
                    self.medicationLog.medicationList.append(med)
                    self.MedicationTable.reloadData()
                    self.dismissViewController(addMedication)
                    self.MedicationTable.reloadData()
                    
                
            }}
        }
    }
    


