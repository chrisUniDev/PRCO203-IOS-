//
//  ViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 04/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    let mainMenu = ["What is RadioTherapy?", "CT Plan", "Treatment Plan Information", "Side Effects Of RadioTherapy", "The Centre"]
    
    let menuTextColourIndex = ["light","light","light","light","light"]
    
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
        cell.lblTitleCell.text = mainMenu[indexPath.row].capitalized
        
        return cell
    }
    
    //Pass information to the detailed view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetialViewController {
            vc.titleimage = imageToPass
            vc.name = titleToPass
        }
    }
    
    //Calls the seque and sets the information ready for the detail view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        imageToPass = UIImage(named: mainMenu[indexPath.row])!
        titleToPass = mainMenu[indexPath.row]
        if titleToPass == "Treatment Plan Information"{
            performSegue(withIdentifier: "DetialViewController", sender: indexPath)
            
        }else if titleToPass == "CT Plan"{
            performSegue(withIdentifier: "CTPlanView", sender: indexPath)
            
        }else if titleToPass == "The Centre" {
            performSegue(withIdentifier: "TheCenterView", sender: indexPath)
        }
        else{
            performSegue(withIdentifier: "SideEffectsView", sender: indexPath)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    

}
