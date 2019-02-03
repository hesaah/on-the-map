//
//  UdacityUsers.swift
//  onTheMap
//
//  Created by Hessah Saad on 23/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation

struct  UdacitySessionBody: Codable {
    let udacity : Udacity
}
struct Udacity: Codable {
    let username : String
    let password : String
}
struct UdacitySessionRespone : Codable{
    let account : Account
    let session : Session
    
}
struct Account: Codable {
    let registered : Bool?
    let key : String?
    
}

struct Session: Codable {
    let id : String?
    let expiration : String?
}
struct SessionDelete : Codable{
    let session : Session
}
struct UdacityUserData : Codable{
    let nickname :String?
}
