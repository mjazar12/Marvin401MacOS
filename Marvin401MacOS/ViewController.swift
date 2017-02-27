//
//  ViewController.swift
//  Marvin401MacOS
//
//  Created by Mazen Azar on 2/23/17.
//  Copyright © 2017 Mazen Azar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var needTableView: NSTableView!
    
    let sizeFormatter = ByteCountFormatter()
    var directory: Directory?
    var directoryItems: [Metadata]?
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true

    override func viewDidLoad() {
        super.viewDidLoad()
        needTableView.delegate = self
        needTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func reloadFileList() {
        directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
        needTableView.reloadData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return directoryItems?.count ?? 0
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NeedID = "NameCellID"
        static let SolutionID = "DateCellID"
//        static let SizeCell = "SizeCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        // 1
        guard let item = directoryItems?[row] else {
            return nil
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            image = item.icon
            text = item.name
            cellIdentifier = CellIdentifiers.NeedID
        } else if tableColumn == tableView.tableColumns[1] {
            text = dateFormatter.string(from: item.date)
            cellIdentifier = CellIdentifiers.SolutionID
        } 
//            else if tableColumn == tableView.tableColumns[2] {
//            text = item.isFolder ? "--" : sizeFormatter.string(fromByteCount: item.size)
//            cellIdentifier = CellIdentifiers.SizeCell
//        }
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
    
}


