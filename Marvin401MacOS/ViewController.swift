//
//  ViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 2/23/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var foodCheckButton: NSButton!
    @IBOutlet weak var transportationCheckButton: NSButton!
    
    @IBOutlet weak var medicationCheckButton: NSButton!
    
    @IBOutlet weak var socializationCheckButton: NSButton!
    
    @IBOutlet weak var depressionCheckButton: NSButton!
    
    @IBOutlet weak var hearingLossCheckButton: NSButton!
    
    @IBOutlet weak var arthritisCheckButton: NSButton!
    
    @IBOutlet weak var addNeedCheckButton: NSButton!
    
    var foodChecked = false;
    var transportationChecked = false;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func ActionListener(_ sender: Any) {
        if foodChecked == false{
            foodChecked = true
            foodCheckButton.image = #imageLiteral(resourceName: "guy")

        }
        else{
            foodChecked = false
            foodCheckButton.image = #imageLiteral(resourceName: "long_term_plan")
        }
    }

}

