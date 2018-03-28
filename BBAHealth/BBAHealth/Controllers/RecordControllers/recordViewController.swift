//
//  recordViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 06/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftSiriWaveformView


class recordViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    
    var timer:Timer?
    var change:CGFloat = 0.01
    
    var clockTimer: Timer?
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    var fractions: Int = 0
    
    var stopWatchString : String = ""

    @IBOutlet weak var stopWatchlbl: UILabel!
    var recordings : Recordings?
    
    @IBOutlet weak var buttonLabel: UIButton!
    //@IBOutlet weak var myTableView: UITableView!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    var numberOfRecord: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioView.density = 1
        
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
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
            numberOfRecord = number
        }
    }
    
    func startTimer(){
        if timer == nil{
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(recordViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer(){
        if timer != nil {
            self.audioView.amplitude = 0
            timer?.invalidate()
            timer = nil
        }
    }
    
    func startClock(){
        
        clockTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(recordViewController.updateStopWatch), userInfo: nil, repeats: true)
        fractions = 0
        seconds = 0
        hours = 0
    }
    
    func stopClock(){
        clockTimer?.invalidate()
    }
    
    @objc func updateStopWatch(){
        fractions += 1
        if fractions == 100{
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60{
            minutes += 1
            seconds = 0
        }
        if minutes == 60{
            hours += 1
            minutes = 0
        }
        
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
        stopWatchString = "\(hoursString) : \(minutesString) : \(secondsString)"
        stopWatchlbl.text = stopWatchString
    }
    
    
   

    
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
            self.change *= -1.0
        }
        
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView.amplitude += self.change
    }



    @IBAction func record(_ sender: Any) {
        
        if audioRecorder == nil{
            numberOfRecord += 1
            recordings?.numberOfRecordings = (recordings?.numberOfRecordings)! + 1
            let fileName = getDirectory().appendingPathComponent("\(numberOfRecord)")
            
            let setting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //start recording
            
            do{
                audioRecorder = try AVAudioRecorder(url: fileName, settings: setting)
                audioRecorder.delegate = self
                try recordingSession.setActive(true)
                try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                audioRecorder.record()
                buttonLabel.setImage(#imageLiteral(resourceName: "stopRecoringButton"), for: .normal)
                //addPulse(numberOfPulses: Float.infinity)
                //buttonLabel.setTitle("Stop Recording", for: .normal)
             
                startTimer()
                startClock()
                
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
            //addPulse(numberOfPulses: 0)
            //myTableView.reloadData()
            UserDefaults.standard.set(numberOfRecord, forKey: "myNumber")
            buttonLabel.setImage(#imageLiteral(resourceName: "recordButton"), for: .normal)
            //buttonLabel.setTitle("Start Recording", for: .normal)
            createAlert()
            stopTimer()
            stopClock()
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
                                name = newName + ""
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

}
