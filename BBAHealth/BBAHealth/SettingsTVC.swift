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
    }

    @IBAction func aboutBtnTapped(_ sender: Any) {
        if let url = URL(string: "https://bbahealth.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}