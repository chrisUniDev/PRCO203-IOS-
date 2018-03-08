//
//  TableViewControllertest.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 07/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import AVFoundation

class RecordedTableViewController: UITableViewController, AVAudioRecorderDelegate {

    var auidoPlayer: AVAudioPlayer!
    
    //var numberOfRecordings: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
            Recordings.numberOfRecordings = number
           
        }
        
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("here")
    
       
        print(Recordings.numberOfRecordings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Recordings.numberOfRecordings
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }



    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //Recordings.audioNames.remove(at: indexPath.row)
            
            
            deleteRecording(num: indexPath.row)
            //try? FileManager.default.removeItem(at: getDirectory().appendingPathComponent("\(indexPath.row+1).m4a"))
            
            Recordings.numberOfRecordings -= 1
            //UserDefaults.standard.removeObject(forKey: "myNumber")
            UserDefaults.standard.set(Recordings.numberOfRecordings, forKey: "myNumber")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func deleteRecording(num: Int){
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]

        
        
       
        let filemanger = FileManager.default
        do {
            let files = try filemanger.contentsOfDirectory(at: documentDirectory,
                                                            includingPropertiesForKeys: nil,
                                                            options: .skipsHiddenFiles)
            //                let files = try fileManager.contentsOfDirectory(at: documentsDirectory)
            
            
           
            
            var recordings = files.filter({ (name: URL) -> Bool in
                return name.pathExtension == "m4a"
                //                    return name.hasSuffix("m4a")
            })
            
            
            
      
            try filemanger.replaceItemAt(recordings[num], withItemAt: recordings[num - 1])
       
         
            /*
            
            do{
                print("Recoding count" + "\(recordings.count)")
                print(num)
                try filemanger.removeItem(at: recordings[num])
                
          
            }catch{
                
            }*/
            
            
            
        }catch{
            
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let recordings = Recordings.audioNames[fromIndexPath.row]
        Recordings.audioNames.remove(at: fromIndexPath.row)
        Recordings.audioNames.insert(recordings, at: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        do{
            auidoPlayer = try AVAudioPlayer(contentsOf: path)
            auidoPlayer.play()
            
        }catch{
            
        }
    }
    



}
