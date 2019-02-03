//
//  ParseConstans.swift
//  onTheMap
//
//  Created by Hessah Saad on 23/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

extension OTMUParseClient {
    struct Constants {
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
    }
    struct URLKeys {
        static let UserID = "id"
        static let ObjectID = "id"
    }
    struct Methods {
        static let StudentLocation = "/StudentLocation"
        static let StudentLocationUpdates = "/StudentLocation/{id}"
    }
    struct  ParametersKeys  {
        static let Order = "order"
        static let Limit = " limit"
        static let Where = "where"
    }
    struct ParametersValue {
        static let Order = "-updatedAt"
        static let Limit = "100"
        static let Where = "{\"uniqueKey\":\"{id}\"}"
        
    }
    
}
