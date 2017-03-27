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
    
    init(){}
    
    init(medName : String, takeDate : String) {
        self.name = medName
        self.date = takeDate
    }
    
    func addName(medName: String){
        self.name = medName;
    }
    
    func setDate(medDate: String){
        self.date = medDate
    }
}
