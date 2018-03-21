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
    
    var recordings : Recordings?
    
    let cellSpacingHeight: CGFloat = 5

    var auidoPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    
    //var numberOfRecordings: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         recordingSession = AVAudioSession.sharedInstance()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
            if recordings?.numberOfRecordings != 0{
                recordings?.numberOfRecordings = (recordings?.numberOfRecordings)! - 1
            }else{
                recordings?.numberOfRecordings = number
            }
            
        }
   
        
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        print(recordings?.numberOfRecordings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (recordings?.numberOfRecordings)!
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path
        
        do {
            if let documentPath = documentsPath
            {
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache after deleting recordings: \(files)")
                
                cell.textLabel?.text = String("\(files[indexPath.row])")
                //cell.textLabel?.text = String("rrr")
                cell.textLabel?.textColor = UIColor.white
                    //UIColor.init(red: 19/255, green: 127/255, blue: 122/255, alpha: 1)
                
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 3
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                    
                
            }
        }catch{
            
        }
        
        
        
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
            
            
            deleteRecording(num: indexPath.row)
            
            recordings?.numberOfRecordings -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(recordings?.numberOfRecordings, forKey: "myNumber")
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func deleteRecording(num: Int){

        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path
        
        do {
            if let documentPath = documentsPath
            {
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache: \(fileNames)")
                
                var i = 0
                for fileName in fileNames {
                    
                    if (i == num)
                    {
                        let filePathName = "\(documentPath)/\(fileName)"
                        try fileManager.removeItem(atPath: filePathName)
                    }
                    i = i + 1
                }
                
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache after deleting recordings: \(files)")
            }
            
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }

    
    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path

        do{
            if let documentPath = documentsPath
            {
                
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                  let path = getDirectory().appendingPathComponent("\(files[indexPath.row])")
                
            auidoPlayer = try AVAudioPlayer(contentsOf: path)
            try recordingSession.setCategory(AVAudioSessionCategoryPlayback)
            auidoPlayer.prepareToPlay()
            auidoPlayer.play()
            }
            
        }catch{
            
        }
    }

}
