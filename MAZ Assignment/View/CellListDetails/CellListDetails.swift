//
//  CellListDetails.swift
//  MAZ Assignment
//
//  Created by Ashish on 26/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit

class CellListDetails: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        imgUser.layer.cornerRadius = 3.0 //self.imgUser.frame.width/2.0
        imgUser.layer.masksToBounds = true
    }

    func bindData(name: String, message: String, gender: String){
        self.lblName.text = name
        self.lblMessage.text = message
        self.lblFooter.text = ""
        
        if gender == "Male" {
            imgUser.image = #imageLiteral(resourceName: "Male")
            
        } else {
            imgUser.image = #imageLiteral(resourceName: "Female")
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
