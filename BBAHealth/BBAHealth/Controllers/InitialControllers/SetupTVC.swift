//
//  SetupTVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 25/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class SetupTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 50, y: self.view.frame.size.height - 130), size: CGSize(width: 100, height: 50)))
        button.backgroundColor = UIColor.white
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        
        self.navigationController?.view.addSubview(button)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //UITableViewHeaderFooterView.appearance().backgroundColor = UIColor.white
        
        
        let topColour = UIColor(red:(15/255.0), green:(118/255.0), blue:(128/255.0), alpha: 1)
        let bottomColour = UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1)
        /*
        let gradient = CAGradientLayer()
        
      
        
        
        gradient.frame = tableView.superview?.bounds ?? CGRect.null
        gradient.colors = [topColour.cgColor, buttomColour.cgColor]
        gradient.locations = [0.0, 1.0]
        //tableView.superview?.layer.mask = gradient

        tableView.superview?.layer.insertSublayer(gradient, at: 0)

        
        tableView.backgroundColor = UIColor.clear
       */
        setTableViewBackgroundGradient(sender: self, topColour, bottomColour)

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let beforeArray = ["Bladder","Brain","Breast","Prostate","Cervical","Kidney","Skin","Liver"]
    let afterArray = [""]
    
    @objc func buttonClicked(sender: UIButton){
        print("Clicked!!!!!")
        
        performSegue(withIdentifier: "StartTab", sender: self)
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartTab"{
            if let desVC = segue.destination as? UITabBarController {
                
            }
        }
    
    }*/
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return beforeArray.count


    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)


        cell.textLabel?.text = self.beforeArray[indexPath.row]
 
        
        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let beforeHeader = "Select Cancer"

        
        return beforeHeader

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.clear
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
     
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

