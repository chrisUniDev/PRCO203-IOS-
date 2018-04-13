//
//  DetialViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import WebKit

class DetialViewController: UIViewController {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var myWebView: WKWebView!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var titleimage = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        getVideo(videoCode: "JN-suUcRdqQ")
        imgImage.image = titleimage
        //imgImage.clipsToBounds = true
        
        //imgImage.contentMode = UIViewContentMode.scaleAspectFill
        lblName.text = name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
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
