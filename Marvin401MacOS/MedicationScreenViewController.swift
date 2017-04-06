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
    
    @IBOutlet weak var MedicationTable: NSTableView!        //field variables
    @IBOutlet weak var Name: NSTextFieldCell!
    @IBOutlet weak var Date: NSTextFieldCell!
    @IBOutlet weak var Dosage: NSTextFieldCell!
    @IBOutlet weak var Instructions: NSTextFieldCell!
    @IBOutlet weak var ID: NSTextFieldCell!
    
    
    var medicationLog = MedicationLog()
    let addMedicationVC = AddMedicationViewController()
    var medicationAdded = Medication()
    
    var sortAcendingName = true
    var sortAcendingDate = true
    var sortAcendingDosage = true
    var sortAcendingInstructions = true
    var sortAcendingID = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationTable.delegate = self
        MedicationTable.dataSource = self
        
        
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let dosageSortDescriptor = NSSortDescriptor(key: "dosage", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let instructionsSortDescriptor = NSSortDescriptor(key: "instructions", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        
        MedicationTable.tableColumns[0].sortDescriptorPrototype = nameSortDescriptor        //sort descriptors
        MedicationTable.tableColumns[1].sortDescriptorPrototype = dateSortDescriptor
        MedicationTable.tableColumns[2].sortDescriptorPrototype = dosageSortDescriptor
        MedicationTable.tableColumns[3].sortDescriptorPrototype = instructionsSortDescriptor
        MedicationTable.tableColumns[4].sortDescriptorPrototype = idSortDescriptor
        
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
        else if tableColumn == tableView.tableColumns[2] {
            if let cell = tableView.make(withIdentifier: "DosageCellID", owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = self.medicationLog.medicationList[row].dosage
                return cell
            }
        }
        else if tableColumn == tableView.tableColumns[3] {
            if let cell = tableView.make(withIdentifier: "InstructionsCellID", owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = self.medicationLog.medicationList[row].instructions
                return cell
            }
        }
        else if tableColumn == tableView.tableColumns[4] {
            if let cell = tableView.make(withIdentifier: "IDCellID", owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = self.medicationLog.medicationList[row].id
                return cell
            }
        }
    
        return nil
    }
    
    
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        
        if(sortAcendingName){                           //sort by name
            self.medicationLog.medicationList = self.medicationLog.sortByName()
            self.MedicationTable.reloadData()
            sortAcendingName = false
        }
        else {
            self.medicationLog.medicationList = self.medicationLog.sortByNameDecending()
            self.MedicationTable.reloadData()
            sortAcendingName = true
        }
        
        if(sortAcendingDate){                           //sort by date
            self.medicationLog.medicationList = self.medicationLog.sortByDate()
            self.MedicationTable.reloadData()
            sortAcendingDate = false
        }
        else {
            self.medicationLog.medicationList = self.medicationLog.sortByDateDecending()
            self.MedicationTable.reloadData()
            sortAcendingDate = true
        }
        
        if(sortAcendingDosage){                             //sort by dosage
            self.medicationLog.medicationList = self.medicationLog.sortByDosage()
            self.MedicationTable.reloadData()
            sortAcendingDosage = false
        }
        else {
            self.medicationLog.medicationList = self.medicationLog.sortByDosageDecending()
            self.MedicationTable.reloadData()
            sortAcendingDosage = true
        }
        
        if(sortAcendingInstructions){                               //sorting by instructions
            self.medicationLog.medicationList = self.medicationLog.sortByInstructions()
            self.MedicationTable.reloadData()
            sortAcendingInstructions = false
        }
        else {
            self.medicationLog.medicationList = self.medicationLog.sortByInstructionsDecending()
            self.MedicationTable.reloadData()
            sortAcendingInstructions = true
        }
        
        if(sortAcendingID){                                         //sorting by id
            self.medicationLog.medicationList = self.medicationLog.sortByID()
            self.MedicationTable.reloadData()
            sortAcendingID = false
        }
        else {
            self.medicationLog.medicationList = self.medicationLog.sortByIDDecending()
            self.MedicationTable.reloadData()
            sortAcendingID = true
        }
        
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
    


