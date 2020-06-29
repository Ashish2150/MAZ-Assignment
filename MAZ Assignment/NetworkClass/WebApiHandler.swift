//
//  WebApiHandler.swift
//  MAZ Assignment
//
//  Created by Ashish on 26/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import UIKit

enum ApiError {
    case NoInternet(message: String)
    case HTTPError(statusCode: Int)
    case ServerError(message: String)
}

class WebAPIHelper: NSObject {
    
    /**********************------This is for Post request------**********************/
    class func callWebAPIPostRequest(apiURL: String,requestParam: [String : AnyObject],CallBack: @escaping ( _ jsonResponse: Data?, _ error : ApiError?, _ statusCode: Int?)->Void) {
        if Reachability.isConnectedToNetwork(){
            let finalUrl = URL(string: apiURL);
            var request = URLRequest(url:finalUrl!)
            request.httpMethod = "POST"
            request.httpBody = self.getParam(params: requestParam).data(using: String.Encoding.utf8)
            request.timeoutInterval = TimeInterval(30)
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                DispatchQueue.main.async {
                    guard data != nil
                        else {
                            CallBack(nil,ApiError.ServerError(message: "Server Error"), 0)
                            return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        CallBack( data, nil, httpResponse.statusCode)
                        
                    }
                    
                }
            }
            task.resume()
        }
        else{
            DispatchQueue.main.async {
                CallBack(nil,ApiError.NoInternet(message: kNoInternet), 0)
            }
        }
    }
    
    
    //MARK:- Convert Parameter into json string form...
    class func getParam(params: [String : AnyObject]) -> String{
        var passparam : String!
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data: jsonData,
                                     encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))
            passparam = theJSONText!
        } catch let error as NSError {
            debugPrint("getParam() \(error)" as AnyObject)
            passparam = ""
        }
        debugPrint("getParam() \(passparam!)" as AnyObject)
        return passparam
    }
}
