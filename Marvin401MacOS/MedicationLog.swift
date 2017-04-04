//
//  MedicationLog.swift
//  Marvin401MacOS
//
//  Created by Muthuppalaniappan sivanadiyan on 3/6/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Foundation

class MedicationLog{
    
    var medicationList = [Medication]()
    
    init() {
        
    }
    
    init(medList : [Medication]) {
        self.medicationList = medList
    }
    
    
    func sortByName() -> [Medication] {
        return medicationList.sorted(by: { $0.name < $1.name })
        
    }
    
    func sortByNameDecending() -> [Medication] {
        return medicationList.sorted(by: { $0.name > $1.name })
        
    }
    
    func sortByDate() -> [Medication] {
        return medicationList.sorted(by: { $0.date < $1.date })
    }
    
    func addMedication(medication:Medication){
        self.medicationList.append(medication)
    }
    
}
