//
//  Loader.swift
//  VegasDiscount
//
//  Created by VegasDiscountNutritionon 01/10/18.
//  Copyright © 2018 VegasDiscountNutrition. All rights reserved.

import UIKit
import QuartzCore
import Foundation

public class Loader
{  
  class func showLoader(controller :UIViewController, loaderText:String, withIndicator: Bool){
    
    var vwProgressPopup = UIView()
    var progressActivityIndicator = UIActivityIndicatorView()
    var lblMessage = UILabel()
    var blackView = UIView()
    blackView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: controller.view.frame.size.width, height: controller.view.frame.size.height))
    blackView.backgroundColor = .black
    blackView.alpha = 0.6
    blackView.tag = 1234
    lblMessage = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
    lblMessage.text = loaderText
    lblMessage.textColor = UIColor.white
    vwProgressPopup = UIView(frame: CGRect(x: controller.view.frame.midX - 90, y: controller.view.frame.midY - 25 , width: 180, height: 50))
    vwProgressPopup.layer.cornerRadius = 15
    vwProgressPopup.backgroundColor = UIColor(white: 0, alpha: 0.7)
    vwProgressPopup.tag = 9999
    
    DispatchQueue.main.async { () -> Void in
      
      if (withIndicator) {
        progressActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        progressActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressActivityIndicator.startAnimating()
        vwProgressPopup.addSubview(progressActivityIndicator)
      }
      
      vwProgressPopup.addSubview(lblMessage)
      controller.view.addSubview(blackView)
      controller.view.addSubview(vwProgressPopup)
      
    }
    
  }
  
  class func hideLoader(controller : UIViewController) {
    DispatchQueue.main.async { () -> Void in
      controller.view.viewWithTag(1234)?.removeFromSuperview()
      controller.view.viewWithTag(9999)?.removeFromSuperview()
      
    }
    
  }
}
