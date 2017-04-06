//
//  MedicationModel.swift
//  Marvin401MacOS
//
//  Created by Muthuppalaniappan sivanadiyan on 3/6/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation

class Medication{
    
    var name = "null"
    var date = "null"
    var dosage = "null"
    var instructions = "null"
    var id = "null"
    
    init(){}
    
    init(medName : String, takeDate : String, dosage : String, instructions : String, id : String) {
        self.name = medName
        self.date = takeDate
        self.dosage = dosage
        self.instructions = instructions
        self.id = id
    }
    
    func addName(medName: String){
        self.name = medName;
    }
    
    func setDate(medDate: String){
        self.date = medDate
    }
    
    func setDosage(medDosage: String){
        self.dosage = medDosage
    }
    
    func setInstructions(medInstructions: String){
        self.instructions = medInstructions
    }
    
    func setID(medID: String){
        self.id = medID
    }
}
