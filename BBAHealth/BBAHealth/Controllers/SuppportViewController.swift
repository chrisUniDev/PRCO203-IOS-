//
//  SuppportViewController.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit
import MessageUI


class SuppportViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == indexPath.first{
            if let url = URL(string: "http://www.tsft.nhs.uk/wards-and-departments/wards/beacon/") {
                UIApplication.shared.open(url, options: [:])
            }}else{
            if let url = URL(string: "http://www.tsft.nhs.uk") {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    let phoneNumber = "07760299823"

    @IBAction func callButtonTapped(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    @IBAction func emailButtonTapped(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["chrislehrer@icloud.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello There!", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
}
