//
//  MapViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.minimumZoomScale = 1.0
        self.scrollview.maximumZoomScale = 6.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }



}
