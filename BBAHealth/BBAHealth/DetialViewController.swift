//
//  DetialViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class DetialViewController: UIViewController {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var titleimage = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        imgImage.image = titleimage
        //imgImage.clipsToBounds = true
        
        //imgImage.contentMode = UIViewContentMode.scaleAspectFill
        lblName.text = name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
