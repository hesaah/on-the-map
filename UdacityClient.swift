//
//  UdacityClient.swift
//  onTheMap
//
//  Created by Hessah Saad on 24/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

extension OTMUdacityClient {
    struct Constants {
        static let ApiSchema = "https"
        static let ApiHost = "onthemap-api.udacity.com"
        static let ApiPath = "/v1"
    }
    struct URLKeys{
        static let UserId = "id"
    }
    struct Methods {
        static let AuthenticationSession = "/session"
        static let AuthenticationGetPublicDataForUserID = "/users/{id}"
    }
}

