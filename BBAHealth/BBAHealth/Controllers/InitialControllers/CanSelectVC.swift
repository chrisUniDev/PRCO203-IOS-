//
//  CanSelectVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 22/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class CanSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var beforeSelectTableView: UITableView!
    @IBOutlet weak var afterSelectTableView: UITableView!
    
    @IBOutlet weak var beforeNamelbl: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    var items: [String] = ["Breast", "Prostate", "Lung", "Skin"]
    var seconditems: [String] = ["123"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.beforeSelectTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.afterSelectTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        

        let topColour = UIColor(red:(15/255.0), green:(118/255.0), blue:(128/255.0), alpha: 1)
        let buttomColour = UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1)
        
        let gradientColours: [CGColor] = [topColour.cgColor, buttomColour.cgColor]
        let gradientLocation: [Float] = [0.0,1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocation as [NSNumber]
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.beforeSelectTableView {
            count = items.count
        }
        
        if tableView == self.afterSelectTableView {
            count = seconditems.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.beforeSelectTableView {
        
            cell = self.beforeSelectTableView.dequeueReusableCell(withIdentifier: "cell")
        
            cell?.textLabel?.text = self.items[indexPath.row]

            
        }
        
        if tableView == self.afterSelectTableView {
            
            cell = self.afterSelectTableView.dequeueReusableCell(withIdentifier: "cell1")
            
            if indexPath.row < seconditems.count{
            
                cell?.textLabel?.text = self.seconditems[indexPath.row]
            }
        }
        
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        
        return cell!
    }
    


}
