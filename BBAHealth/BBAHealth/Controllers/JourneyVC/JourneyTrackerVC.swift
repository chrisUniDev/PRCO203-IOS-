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
    @IBOutlet weak var stage4View: DesignableView!
    
    
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

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JourneyTrackerVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }


    @IBAction func indexControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            stage1View.isHidden = false
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = true
        case 1:
            stage1View.isHidden = true
            stage2View.isHidden = false
            stage3View.isHidden = true
            stage4View.isHidden = true
        case 2:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = false
            stage4View.isHidden = true
        case 3:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = false
        case 4:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = false
        case 5:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = false
        case 6:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = false
        case 7:
            stage1View.isHidden = true
            stage2View.isHidden = true
            stage3View.isHidden = true
            stage4View.isHidden = false
        default:
            stage1View.isHidden = true
            stage2View.isHidden = false
            stage3View.isHidden = true
            stage4View.isHidden = true
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

 

}
