//
//  ViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/02/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.frame = view.frame
        
        imageArray = [#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2")]
      
        for i in 0..<imageArray.count {
            
            
            let buttonView = UIButton()
            
            buttonView.setImage(imageArray[i], for: .normal)
            buttonView.contentMode = .scaleAspectFit
            
            let yPosition = 460 * CGFloat(i)
            buttonView.frame = CGRect(x: 0, y: yPosition, width: 330, height: 400)
            
            scrollView.contentSize.height = scrollView.frame.height * CGFloat(i + 1)
            scrollView.addSubview(buttonView)
           
            buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.frame.width - 330)/2).isActive = true
            //buttonView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

            buttonView.layer.cornerRadius = 14
            buttonView.layer.masksToBounds = true
            
            
  
        }
        
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



