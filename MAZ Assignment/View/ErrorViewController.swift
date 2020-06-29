//
//  ErrorViewController.swift
//  MAZ Assignment
//
//  Created by Ashish on 27/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit

protocol ErrorDelegate {
    func errorButtonAction()
    
}


class ErrorViewController: UIViewController {

    var delegate: ErrorDelegate?
    var errorMessage = ""
    
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblErrorMessage.text = errorMessage
        // Do any additional setup after loading the view.
    }
    
    @IBAction func retryButtonAction(_ sender: Any) {
        delegate?.errorButtonAction()
        self.dismiss(animated: false, completion: nil)
    }
    

    
}
