//
//  ExOTMParseClient.swift
//  onTheMap
//
//  Created by Hessah Saad on 25/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation
import  UIKit



extension OTMUParseClient {
    
    
    
    func getAllDataFromUsers(_ completionHandlerForUserID:  @escaping   (_ success : Bool ,_ usersData : [Any]?, _ errorString : String?)-> Void) {
        
        let parameters = [OTMUParseClient.ParametersKeys.Limit:OTMUParseClient.ParametersValue.Limit , OTMUParseClient.ParametersKeys.Order : OTMUParseClient.ParametersValue.Order]
        _ = taskForGETMethod(OTMUParseClient.Methods.StudentLocation, parameters: parameters as [String : AnyObject], decode: StudentLocations.self) { (result, error) in
            
            if let error = error {
                completionHandlerForUserID(false , nil , "\(error.localizedDescription)")
            }else {
                let newResult = result as! StudentLocations
                if let usersData = newResult.results{
                    completionHandlerForUserID(true,usersData, nil)
                } else {
                    completionHandlerForUserID(false , nil , "\(error!.localizedDescription)")
                }
            }
        }
        
    }
    
    
    func getUserDataByUniqKey(_ completionHandlerForUserID:  @escaping   (_ success : Bool ,_ objectId: String?, _ errorString : String?)-> Void){
        
        let method : String = Methods.StudentLocation
        let newParametersValue = substituteKeyInMethod(OTMUParseClient.ParametersValue.Where, key: OTMUParseClient.URLKeys.UserID, value: OTMUdacityClient.sharedInstance().userId!)!
        
        let parameters = [OTMUParseClient.ParametersKeys.Where : newParametersValue]
        
        _ = taskForGETMethod(method, parameters: parameters as [String : AnyObject], decode: StudentLocations.self) { (result, error) in
            
            if let error = error {
                completionHandlerForUserID(false , nil , "\(error.localizedDescription)")
            } else {
                let newResult = result as! StudentLocations
                if !((newResult.results?.isEmpty)!){
                    if let userData = newResult.results{
                        if let objectId = userData[0].objectId {
                            OTMUParseClient.sharedInstance().objectId = objectId
                        }
                        completionHandlerForUserID(true , self.objectId , nil)
                    } else {
                        completionHandlerForUserID(false , nil , "\(error!.localizedDescription)")
                    }
                } else {
                    completionHandlerForUserID(true , self.objectId , nil)

                }
                
            }
            
        }
        
    }
    
    
    func postUserLocation<E:Encodable>( jsonBody :E , completionHandlerForSession:  @escaping (_ success : Bool , _ errorString : String?)   ->Void   ){
        
        _ = taskForPOSTMethod(Methods.StudentLocation, decode: StudentLocationsResponse.self, jsonBody: jsonBody ){ (result, error) in
            
            if let error = error {
                completionHandlerForSession(false , "\(error.localizedDescription) ")
            } else {
                if result != nil {
                    completionHandlerForSession(true , nil)
                } else {
                     completionHandlerForSession(false , "\(error!.localizedDescription) ")
                    
                }
            }
            
            
        }
        
    }
    
    
    
    func putUserLocation<E:Encodable>( jsonBody :E , completionHandlerForSession:  @escaping (_ success : Bool , _ errorString : String?)   ->Void   ){
        
        var mutableMethods : String = Methods.StudentLocationUpdates
        mutableMethods = substituteKeyInMethod(mutableMethods, key: URLKeys.ObjectID, value: String(self.objectId!))!
        _ = taskForPUTMethod(mutableMethods, decode: StudentLocationsUpdateResponse.self, jsonBody: jsonBody) { (result , error) in
            
            
            if let error = error {
                completionHandlerForSession(false , "\(error.localizedDescription) ")
            } else {
                if result != nil {
                    completionHandlerForSession(true , nil)
                } else {
                    completionHandlerForSession(false , "\(error!.localizedDescription) ")
                    
                }
            
            
            
            
            
            
        }
        
        
        
        
    }
    
        
    }
    
    
    
}
