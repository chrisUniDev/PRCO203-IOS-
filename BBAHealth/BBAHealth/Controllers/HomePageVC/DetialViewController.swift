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
    
    @IBOutlet weak var visualEffectBlur: UIVisualEffectView!
    @IBOutlet weak var myscrollview: UIScrollView!
    
    //video outlets
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myWebView1: WKWebView!
    //@IBOutlet weak var myWebView2: WKWebView!
    
    
    let weblinks : [String] = ["x7OAR3oJknY", "xIn6eqbHs2g"]
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var titleimage = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

        imgImage.image = titleimage
        lblName.text = name
        
        if lblName.text == "Treatment Plan Information"{
            let webviews = [myWebView, myWebView1]
            var count = 0
            for webview in webviews{
                getVideo(videoCode: weblinks[count], webview: webview!)
                count += 1
            }}
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    


    func getVideo(videoCode: String, webview: WKWebView){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        webview.load(URLRequest(url: url!))
        
    }
    


}


