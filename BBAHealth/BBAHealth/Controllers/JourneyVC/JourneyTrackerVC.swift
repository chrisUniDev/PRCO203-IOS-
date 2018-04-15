//
//  JourneyTrackerVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class JourneyTrackerVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stage1View: UIView!
    @IBOutlet weak var stage2View: UIView!
    @IBOutlet weak var stage3View: UIView!
    
    
    @IBOutlet weak var waitProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var overallProgressBar: MBCircularProgressBarView!
    
    //Stage 1 switchs
    @IBOutlet weak var ResultsMeetingSwitch: UISwitch!
    @IBOutlet weak var MRISwitch: UISwitch!
    
    
    @IBAction func ResultsMeetingToggled(_ sender: Any) {
        if ResultsMeetingSwitch.isOn{
            [UIView .animate(withDuration: 1.0, animations: {
                self.overallProgressBar.value += 5.0
            })]
        }else{
            [UIView .animate(withDuration: 1.0, animations: {
                self.overallProgressBar.value -= 5.0
            })]
        }
    }
    
    @IBAction func MRISwtichToggled(_ sender: Any) {
        if MRISwitch.isOn{
            [UIView .animate(withDuration: 1.0, animations: {
                self.overallProgressBar.value += 10.0
                })]
            
        }else{
            [UIView .animate(withDuration: 1.0, animations: {
                self.overallProgressBar.value -= 10.0
            })]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func indexControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            stage1View.isHidden = false
            stage2View.isHidden = true
            stage3View.isHidden = true
        case 1:
            stage1View.isHidden = true
            stage2View.isHidden = false
            stage3View.isHidden = true
        case 2:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = false
        default:
            stage1View.isHidden = true
            stage2View.isHidden = false
        }
    }
    

 

}
