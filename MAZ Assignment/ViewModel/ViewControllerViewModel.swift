//
//  ViewControllerViewModel.swift
//  MAZ Assignment
//
//  Created by Ashish on 27/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import Foundation

class ViewControllerViewModel: NSObject {
    
    
    var modelUserList : [UserListModel]?
    
    /**
     Call Api to get list data from the webserver...
     - Parameters : none
     - Returns: void.
     */
    func callPostWebAPIForGetDetails(parameter:[String:AnyObject], getCallBack:@escaping(_ success:Bool, _ message:String? ,_ error:ApiError?, _ statusCode: Int?)->Void) {
        
        let apiURL = "http://www.mocky.io/v2/5e25329d2f00007f00ce27e5"
        
        debugPrint(apiURL)
        WebAPIHelper.callWebAPIPostRequest(apiURL: apiURL, requestParam: parameter) { (jsonResponse, error, statusCode) in
            
            if error == nil {
                do {
                    if statusCode == 200 {
                        let decoder = JSONDecoder()
                        let objModel = try decoder.decode([UserListModel].self, from: jsonResponse!)
                        self.modelUserList = objModel
                        getCallBack(true, nil, error, statusCode)
                        
                    } else {
                        getCallBack(false, "Server Error", ApiError.ServerError(message: "Server Error"), statusCode)
                    }
                }
                catch let errorDescription {
                    debugPrint(errorDescription)
                    getCallBack(false, "Server Error", ApiError.ServerError(message: "Server Error"), statusCode)
                    
                }
            } else {
                getCallBack(false, kNoInternet, error, statusCode)
            }
        }
    }
}
