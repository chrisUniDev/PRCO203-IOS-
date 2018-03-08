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

    @IBOutlet weak var buttonLabel: UIButton!
    //@IBOutlet weak var myTableView: UITableView!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var auidoPlayer: AVAudioPlayer!
    
    var numberOfRecord: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
            numberOfRecord = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission
            {
                print ("ACCEPTED")
            }
        }
    }



    @IBAction func record(_ sender: Any) {
        
        if audioRecorder == nil{
            numberOfRecord += 1
            Recordings.numberOfRecordings = numberOfRecord
            let fileName = getDirectory().appendingPathComponent("\(numberOfRecord).m4a")
            
            let setting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //start recording
            
            do{
                audioRecorder = try AVAudioRecorder(url: fileName, settings: setting)
                audioRecorder.delegate = self
                audioRecorder.record()
               
                buttonLabel.setTitle("Stop Recording", for: .normal)
            }catch{
                displayAlert(title: "Opps!", message: "Recording failed")
              
            }
        }else{
            //stop audio recording
            audioRecorder.stop()
            audioRecorder = nil
            
            
            //myTableView.reloadData()
            UserDefaults.standard.set(numberOfRecord, forKey: "myNumber")
            
            buttonLabel.setTitle("Start Recording", for: .normal)
        }
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
