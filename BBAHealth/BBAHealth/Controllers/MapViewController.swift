//
//  MapViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var mapImageview: DesignableImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var transportView: UIView!
    
    let imageArray = [#imageLiteral(resourceName: "Taunton_Map"),#imageLiteral(resourceName: "floor_map")]
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollview.minimumZoomScale = 1.0
        self.scrollview.maximumZoomScale = 6.0
        self.scrollview.zoomScale = 1.65
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func indexControl(_ sender: Any) {
        switch segmentController.selectedSegmentIndex {
        case 0:
            mapImageview.image = imageArray[0]
            mapImageview.isHidden = false
            transportView.isHidden = true
        case 1:
            mapImageview.image = imageArray[1]
            mapImageview.isHidden = false
            transportView.isHidden = true
        case 2:
            mapImageview.isHidden = true
            transportView.isHidden = false
        default:
            mapImageview.image = imageArray[0]
            mapImageview.isHidden = false
            transportView.isHidden = true
        }
    }
    
    @IBAction func onMoreTapped() {
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @IBAction func howToGetHereNavTapped(_ sender: Any) {
        
        let latitude: CLLocationDegrees = 51.012121
        let logitude: CLLocationDegrees =  -3.119883
        
        let regionDistance : CLLocationDistance = 1000
        let corrdinates = CLLocationCoordinate2DMake(latitude, logitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(corrdinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: corrdinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Hospital"
        mapItem.openInMaps(launchOptions: options)
    }
    



}
