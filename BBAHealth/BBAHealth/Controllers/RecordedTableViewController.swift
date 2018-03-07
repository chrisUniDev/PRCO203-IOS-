//
//  RecordedTableViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 07/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class RecordedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recordings = ["test1","test2","test3","test4"]
    
    @IBOutlet weak var TableView: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recordings.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recordings[indexPath.row]
        return cell
    }
    
    
    
    
    // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }

}
