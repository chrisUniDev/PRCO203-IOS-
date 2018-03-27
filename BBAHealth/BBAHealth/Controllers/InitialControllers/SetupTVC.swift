//
//  SetupTVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 25/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class SetupTVC: UITableViewController, CALayerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    private var gradient: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateWordDict()
        
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.1, 0.9, 1]
        
        let topColour = UIColor(red:(15/255.0), green:(118/255.0), blue:(128/255.0), alpha: 1)
        let bottomColour = UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1)
        
        
        let button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 50, y: self.view.frame.size.height - 110), size: CGSize(width: 100, height: 40)))
        button.backgroundColor = UIColor.white
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(red:(19/255.0), green:(127/255.0), blue:(122/255.0), alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        
        
        let bottomView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: self.view.frame.height - 160), size: CGSize(width: self.view.frame.width, height: 200)))
        bottomView.backgroundColor = bottomColour
        bottomView.layer.mask = gradient
        bottomView.isUserInteractionEnabled = false
        
        
        self.navigationController?.view.addSubview(bottomView)
        self.navigationController?.view.addSubview(button)
        


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
    
    let beforeArray = ["Anal","Adrenortical","Bladder","Bone","Brain","Breast","Carcinoid","Carcinoma","Cervical","Colorectal","Head & Neck","Kidney","Liver","Prostate","Skin","Uterine"]
    var selectedArray : [String] = []
    
    let wordsIndextitles = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var wordsSelection = [String]()
    var wordDict = [String:[String]]()
    
    func generateWordDict(){
        for word in beforeArray {
            let wordKey = String(word.prefix(1))
            if var wordValues = wordDict[wordKey] {
                wordValues.append(word)
                wordDict[wordKey] = wordValues
            } else {
                wordDict[wordKey] = [word]
            }
        }
        
        // 2
        wordsSelection = [String](wordDict.keys)
        wordsSelection = wordsSelection.sorted(by: { $0 < $1 })
    }
  
    
    @objc func buttonClicked(sender: UIButton){
    
        if selectedArray.count == 0 {
            print("oh dear")
            createAlert()
        }else{
            performSegue(withIdentifier: "StartTab", sender: self)
        }
        
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
        return wordsSelection.count
        //return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let wordKey = wordsSelection[section]
        if let wordValues = wordDict[wordKey] {
            return wordValues.count
        }
        
        //return beforeArray.count
        return 0

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let wordKey = wordsSelection[indexPath.section]
        if let wordValues = wordDict[wordKey]{
             cell.textLabel?.text = wordValues[indexPath.row]
        }

       

 
        
        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordsIndextitles
    }
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let beforeHeader = "Select Cancer"
        return wordsSelection[section]

    }*/
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = wordsSelection.index(of: title) else{
            return -1
        }
        return index
    }
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 17, y: -12.5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 17)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
 */
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.clear
        let image = UIImage(named: "checkmark.png")
        let imageView = UIImageView(image: image)
        
        print(indexPath.row)
        print(indexPath.section)
        /*
        let wordKey = wordsSelection[indexPath.section]
        if wordDict[wordKey] != nil{
            cell.accessoryView = imageView
            
        }*/
        
        
   
        //tableView.cellForRow(at: [indexPath.section,indexPath.row])?.accessoryView = imageView
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        selectedArray.append(String((tableView.cellForRow(at: indexPath)?.textLabel?.text)!))
        print(selectedArray)
        
        
       
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        selectedArray = selectedArray.filter(){$0 != String((tableView.cellForRow(at: indexPath)?.textLabel?.text)!)}
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
    
    func createAlert(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Please select an option!", message: "Select one or mutliple.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
 
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }

}

