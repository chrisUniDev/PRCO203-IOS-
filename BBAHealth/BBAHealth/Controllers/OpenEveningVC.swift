//
//  OpenEveningVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 22/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import WebKit

class OpenEveningVC: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode: "JN-suUcRdqQ")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        myWebView.load(URLRequest(url: url!))
        
    }
    


}
