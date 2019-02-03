//
//  ActivityIndicator.swift
//  onTheMap
//
//  Created by Hessah Saad on 23/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation
import UIKit
struct ActivityIndicator {
    private static var activityIndicator :UIActivityIndicatorView = UIActivityIndicatorView()
    static func startActivityIndicator( view: UIView){
        activityIndicator.color = .blue
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    static func stopActivityIndicator(){
        activityIndicator.stopAnimating()
    }
}
