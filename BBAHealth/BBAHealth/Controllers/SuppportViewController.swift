//
//  SuppportViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit



class SuppportViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let supportArray = ["SupportBlank1","NHSSupport"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supportArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! SupportCollectionViewCell
        
        cell.imageCell.image = UIImage(named: supportArray[indexPath.row])
        //cell.lblTitleCell.text = "Beacon Center"
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }



}
