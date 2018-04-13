//
//  RecordTVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 28/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func showActionSheet()
}

class RecordTVC: UITableViewCell {
    var delegate: CustomCellDelegate?
    
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func sharePressed(_ sender: Any) {

        if let delegate = self.delegate {
            delegate.showActionSheet()
        }
    }
    
}
