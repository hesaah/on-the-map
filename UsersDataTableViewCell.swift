//
//  UsersDataTableViewCell.swift
//  onTheMap
//
//  Created by Hessah Saad on 20/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import UIKit
class UsersDataTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!

    @IBOutlet weak var urlLabel: UILabel!
    func fillCell(usersData : Results){
        if let first = usersData.firstName , let last = usersData.lastName , let url = usersData.mediaURL {
            fullNameLabel.text = "\(first) \(last)"
            urlLabel.text = "\(url)"
        }
    }
    
    
    
    
}

