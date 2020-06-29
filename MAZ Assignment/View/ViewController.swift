//
//  ViewController.swift
//  MAZ Assignment
//
//  Created by Ashish on 26/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewControllerViewModel()
    
    //MARK:- view life cycle...
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        viewSetup()
        callApiForGetDetails()
        
        
    }
    
    //MARK:- Helper methods..
    func registerNib(){
        tableView.register(UINib(nibName: "CellListDetails", bundle: nil), forCellReuseIdentifier: "CellListDetails")
    }
    
    func viewSetup(){
        tableView.layer.cornerRadius = 10.0
        tableView.layer.shadowColor = UIColor.lightGray.cgColor
        tableView.layer.shadowRadius = 10
        tableView.layer.shadowOpacity = 0.8
        tableView.layer.shadowOffset = CGSize(width: 0 , height: 0)
        tableView.layer.masksToBounds = false
       
    
        
    }
    
    //MARK:- Call api for fetch data
    func callApiForGetDetails(){
        
        Loader.showLoader(controller: self, loaderText: "Please wait...", withIndicator: true)
        viewModel.callPostWebAPIForGetDetails(parameter: [:]) { (success, message, error, statusCode) in
            Loader.hideLoader(controller: self)
            if success {
                if self.viewModel.modelUserList?.count ?? 0 > 0 {
                    self.tableView.isHidden = false
                } else {
                    self.tableView.isHidden = true
                }
                self.tableView.reloadData()
                
            } else {
                let controller = self.storyboard?.instantiateViewController(identifier: "ErrorViewController") as! ErrorViewController
                controller.errorMessage = message ?? "Error"
                controller.delegate = self
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: false, completion: nil)
                
            }
        }
    }
    
    
    
}


//MARK:- Table view delegate and datasource...
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelUserList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellListDetails", for: indexPath) as? CellListDetails else {
            return UITableViewCell()
        }
        let modelData = viewModel.modelUserList?[indexPath.row]
        cell.bindData(name: "\(modelData?.firstName ?? "") \(modelData?.lastName ?? "")", message: modelData?.message ?? "", gender: modelData?.gender ?? "Male")
        
        return cell
    }
    
}


//MARK:- Perform actino based on the callback of error button..
extension ViewController: ErrorDelegate {
    func errorButtonAction() {
        self.callApiForGetDetails()
    }
    
    
}


extension UIViewController {
    /*************------This is alert popup with single buttons------*****************/
    func showAlertPopUpWithSingleButton(title:String, message:String, buttonTitle : String, completion : @escaping (_ buttonClicked: Bool)->Void){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let btnAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (UIAlertAction)in
            completion(true)
        })
        alertController.addAction(btnAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
