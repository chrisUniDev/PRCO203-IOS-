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
    
    let imageWidth: CGFloat = 330
    let imageHeight: CGFloat = 400
    let buttonSepationPadding: CGFloat = 460
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.frame = view.frame
        
        imageArray = [#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2")]
        
        createButtons(buttons: imageArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createButtons(buttons: [UIImage]){
        
        for i in 0..<buttons.count {
            
            let buttonView = UIButton()
            
            buttonView.setImage(buttons[i], for: .normal)
            buttonView.contentMode = .scaleAspectFit
            
            let yPosition = buttonSepationPadding * CGFloat(i)
            buttonView.frame = CGRect(x: 0, y: yPosition, width: imageWidth, height: imageHeight)
            
            scrollView.contentSize.height = scrollView.frame.height + (buttonSepationPadding * CGFloat(i))
            scrollView.addSubview(buttonView)
            
            buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.frame.width - imageWidth)/2).isActive = true
            
            //Creates the corners on each button image
            buttonView.layer.cornerRadius = 14
            buttonView.layer.masksToBounds = true
        }
        //Removes unwanted bottom white space
        scrollView.contentSize.height = scrollView.contentSize.height - 160
    }
}



