//
//  ViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/02/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    var buttonArray = [UIButton]() //access all buttons through here...
    
    let imageWidth: CGFloat = 330
    let imageHeight: CGFloat = 400
    let buttonSepationPadding: CGFloat = 460
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.frame = view.frame
        UIApplication.shared.statusBarStyle = .default
        imageArray = [#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2"),#imageLiteral(resourceName: "InfoView_TitleImage_1"),#imageLiteral(resourceName: "InfoView_TitleImage_2")]
        buttonArray = createButtons(images: imageArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createButtons(images: [UIImage]) -> [UIButton]{
        
        var tempButtonArray = [UIButton]()
        
        for i in 0..<images.count {
            
            let button = UIButton()
            
            //adds the image to the button
            button.setImage(images[i], for: .normal)
            button.contentMode = .scaleAspectFit
            
            //sizes and positions the button in the view
            let yPosition = buttonSepationPadding * CGFloat(i)
            button.frame = CGRect(x: 0, y: yPosition, width: imageWidth, height: imageHeight)
            
            //resizes the scrollview
            scrollView.contentSize.height = scrollView.frame.height + (buttonSepationPadding * CGFloat(i))
            scrollView.addSubview(button)
            
            //Centers the button horizontally
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.frame.width - imageWidth)/2).isActive = true
            
            //Creates the corners on the button image
            button.layer.cornerRadius = 14
            button.layer.masksToBounds = true
            
            tempButtonArray.append(button)
        }
        //Removes unwanted bottom white space
        scrollView.contentSize.height = scrollView.contentSize.height - 160
        
        return tempButtonArray
    }
}



