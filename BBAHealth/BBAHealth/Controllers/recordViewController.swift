//
//  recordViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 06/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import AVFoundation


class recordViewController: UIViewController, AVAudioRecorderDelegate {


    var recordings : Recordings?
    
    @IBOutlet weak var buttonLabel: UIButton!
    //@IBOutlet weak var myTableView: UITableView!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var pulse: Pulsing!
    
    var numberOfRecord: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { (hasPermission) in
                if hasPermission
                {
                    print ("ACCEPTED")
                }
            }
        } catch {
        
        }
        // Do any additional setup after loading the view.
        
     
   
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
            numberOfRecord = number
        }
        
      
    }
    
   
    
    func addPulse(numberOfPulses: Float){
        pulse = Pulsing(numberOfPulses: numberOfPulses, radius: 150, position: buttonLabel.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(pulse, below: buttonLabel.layer)
    }



    @IBAction func record(_ sender: Any) {
        
        if audioRecorder == nil{
            numberOfRecord += 1
            recordings?.numberOfRecordings = (recordings?.numberOfRecordings)! + 1
            let fileName = getDirectory().appendingPathComponent("\(numberOfRecord).m4a")
            
            let setting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //start recording
            
            do{
                audioRecorder = try AVAudioRecorder(url: fileName, settings: setting)
                audioRecorder.delegate = self
                try recordingSession.setActive(true)
                try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                audioRecorder.record()
                buttonLabel.setImage(#imageLiteral(resourceName: "stopRecoringButton"), for: .normal)
                addPulse(numberOfPulses: Float.infinity)
                //buttonLabel.setTitle("Stop Recording", for: .normal)
            }catch{
                displayAlert(title: "Opps!", message: "Recording failed")
              
            }
        }else{
            //stop audio recording
            audioRecorder.stop()
            do{
            try recordingSession.setActive(false)
            try recordingSession.setCategory(AVAudioSessionCategoryPlayback)
            }catch{
                
            }
            audioRecorder = nil
            addPulse(numberOfPulses: 0)
            //myTableView.reloadData()
            UserDefaults.standard.set(numberOfRecord, forKey: "myNumber")
            buttonLabel.setImage(#imageLiteral(resourceName: "recordButton"), for: .normal)
            //buttonLabel.setTitle("Start Recording", for: .normal)
            createAlert()
        }
    }
    
    func createAlert(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Name of Recording", message: "Enter a name", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            
            let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            let documentsPath = documentsUrl.path
            let fileManager = FileManager.default
            
            do{
                if let documentPath = documentsPath{
                    let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                   
                    for fileName in fileNames {
                        
                        if (fileName == fileNames.last)
                        {
                            let filePathName = "\(documentPath)/\(fileName)"
                            var name = ""
                            if let newName = textField?.text{
                                name = newName + ".m4a"
                            }
                            let newFilePathName = "\(documentPath)/\(name)"
                            try FileManager.default.moveItem(atPath: filePathName, toPath: newFilePathName)
                        }
              
                    }
                    let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                    print("all files in cache after deleting recordings: \(files)")
                }
            }catch{
                
            }
            
  
            
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    func displayAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    
    
    //TableView//
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecord
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        do{
            auidoPlayer = try AVAudioPlayer(contentsOf: path)
            auidoPlayer.play()
            print(indexPath.row + 1)
           
        }catch{
            print("NotWorking")
        }
    }
 */
    


}
