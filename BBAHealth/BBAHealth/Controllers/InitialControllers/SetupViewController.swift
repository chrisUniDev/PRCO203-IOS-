//
//  SetupViewController.swift
//  Test Project
//
//  Created by Christopher Lehrer on 03/02/2018.
//  Copyright © 2018 Christopher Lehrer. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var logoImageView: DesignableImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let topColour = UIColor(red:(15/255.0), green:(118/255.0), blue:(128/255.0), alpha: 1)
        let buttomColour = UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1)
        
        let gradientColours: [CGColor] = [topColour.cgColor, buttomColour.cgColor]
        let gradientLocation: [Float] = [0.0,1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocation as [NSNumber]
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
       //animateup()
      
    }
    
    
    func animateup(){
        UIView.animate(withDuration: 1.0, delay: 0, animations: ({
            self.logoImageView.frame.origin.y -= 10
        }), completion: { (true) in
            self.aniatmeDown()
        })
    }
    
    func aniatmeDown(){
        UIView.animate(withDuration: 1.0, delay: 0, animations: ({
            self.logoImageView.frame.origin.y += 10
        }), completion: { (true) in
            self.animateup()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
}
