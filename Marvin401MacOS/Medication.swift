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
    
    init(medName : String, takeDate : String) {
        self.name = medName
        self.date = takeDate
    }
    
}
