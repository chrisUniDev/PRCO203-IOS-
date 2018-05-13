//
//  supportController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 13/05/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

//
//  ViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class SupportVeiwController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let mainMenu = ["takecare", "notalone", "comtherapy", "conselling", "questions", "family", "money", "links"]
    
    let mainmenuText = ["Taking Care of Yourself", "You are not alone", "Complimentary Therapy", "Counselling", "Common Questions", "Friends and Family", "Finance", "Links & web resources"]
    
    let menuTextColourIndex = ["dark","dark","dark","dark","dark","dark","dark","dark"]
    
    var imageToPass = UIImage()
    var titleToPass = ""
    
    
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = false
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    //Adds the information to each cell on the homeView
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        
        cell.imageCell.image = UIImage(named: mainMenu[indexPath.row])
        if menuTextColourIndex[indexPath.row] == "light"{
            cell.lblTitleCell.textColor = .white
        }else{
            cell.lblTitleCell.textColor = .darkGray
        }
        //cell.lblTitleCell.text = mainMenu[indexPath.row].capitalized
        cell.lblTitleCell.text = mainmenuText[indexPath.row].capitalized
        return cell
    }
    
    //Pass information to the detailed view
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetialViewController {
            vc.titleimage = imageToPass
            vc.name = titleToPass
        }
    }*/
    
    //Calls the seque and sets the information ready for the detail view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     
        
        
        //imageToPass = UIImage(named: mainMenu[indexPath.row])!
        titleToPass = mainmenuText[indexPath.row]
        if titleToPass == "Links & web resources"{
            performSegue(withIdentifier: "QuickLinks", sender: indexPath)
        }else{
            performSegue(withIdentifier: "comingSoon", sender: indexPath)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
}

