//
//  SettingsTVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 13/04/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsTVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func aboutBtnTapped(_ sender: Any) {
        if let url = URL(string: "https://bbahealth.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    

    @IBAction func resetButtonTapped(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "targetSavings")
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "backToInitial", sender: nil)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
