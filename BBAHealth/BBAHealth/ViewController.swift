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
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let yPosition = self.view.frame.height * CGFloat(i)
            imageView.frame = CGRect(x: 0, y: yPosition, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            
            scrollView.contentSize.height = scrollView.frame.height * CGFloat(i + 1)
            scrollView.addSubview(imageView)
            
            
            
        }
        
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

