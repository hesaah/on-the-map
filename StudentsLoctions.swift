//
//  StudentsLoctions.swift
//  onTheMap
//
//  Created by Hessah Saad on 25/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation



struct StudentLocations : Codable {
    let results : [Results]?
}
struct Results : Codable {
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
    
}




struct StudentLocationsBody : Codable {
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    
    
}



struct StudentLocationsResponse : Codable{
     let createdAt: String?
    let objectId: String?

    
}


struct StudentLocationsUpdateResponse : Codable {
    let createdAt: String?
    
}

