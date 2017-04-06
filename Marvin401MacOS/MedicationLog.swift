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
    
    func sortByDateDecending() -> [Medication] {
        return medicationList.sorted(by: { $0.date > $1.date })
    }

    
    func sortByDosage() -> [Medication] {
        return medicationList.sorted(by: { $0.dosage < $1.dosage })
        
    }
    
    func sortByDosageDecending() -> [Medication] {
        return medicationList.sorted(by: { $0.dosage > $1.dosage })
        
    }
    
    func sortByInstructions() -> [Medication] {
        return medicationList.sorted(by: { $0.instructions < $1.instructions })
        
    }
    
    func sortByInstructionsDecending() -> [Medication] {
        return medicationList.sorted(by: { $0.instructions > $1.instructions })
        
    }
    
    func sortByID() -> [Medication] {
        return medicationList.sorted(by: { $0.id < $1.id })
        
    }
    
    func sortByIDDecending() -> [Medication] {
        return medicationList.sorted(by: { $0.id > $1.id })
        
    }
    
    
    func addMedication(medication:Medication){
        self.medicationList.append(medication)
    }
    
}
