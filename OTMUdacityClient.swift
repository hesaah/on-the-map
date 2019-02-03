//
//  OTMUdacityClient.swift
//  onTheMap
//
//  Created by Hessah Saad on 24/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation
class OTMUdacityClient : NSObject {
     let session = URLSession.shared
    
    
    var sessionID :String? = nil
    var userId:String? = nil
    var nickname : String? = nil
    
    
    override init() {
        
        super.init()
    }
    func taskForGETMethod<D:Decodable>(_ method: String , decode:D.Type , completionHandlerForGET: @escaping(_ result : AnyObject? , _ error: NSError?)-> Void) -> URLSessionDataTask {
        
        let request = NSMutableURLRequest(url : OTMUdacityClient.tmdbURLFromWithoutParameters(withPathExtension: method))
      
        let task = session.dataTask(with: request as URLRequest){ (data ,response , error ) in
            func sendError(_ error:String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil , NSError(domain: "task for get Method", code: 1, userInfo: userInfo))
            }
            
            guard ( error == nil) else
            {
                sendError("\(error!.localizedDescription)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request! " )
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            self.convertDataWithCompletionHandler(newData, decode: decode, completionHandlerForConvertData: completionHandlerForGET)
    }
        
     task.resume()
        return task
        
    }
    func taskForPOSTMethod<E:Encodable,D:Decodable>(_ method : String , decode : D.Type? , jsonBody : E ,completionHandlerForPOST:@escaping(_ result : AnyObject? , _ error: NSError?)-> Void) -> URLSessionDataTask {
        func sendError(_ error:String){
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForPOST(nil , NSError(domain: "task for post Method", code: 1, userInfo: userInfo))}
        let request = NSMutableURLRequest(url: OTMUdacityClient.tmdbURLFromWithoutParameters(withPathExtension: method))
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do{
                let JsonBody = try JSONEncoder().encode(jsonBody)
                request.httpBody = JsonBody
            }catch{
                sendError("there was an error \(error)")
            }
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
                
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            self.convertDataWithCompletionHandler(newData, decode: decode!, completionHandlerForConvertData:completionHandlerForPOST)
        }
        
            
            
          task.resume()
        return task
            
        
            
        }
    
    func taskForDeleteMethod<D:Decodable>(_ method: String,decode:D.Type?, completionHandlerForDelete: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForDelete(nil, NSError(domain: "taskForDeleteMethod", code: 1, userInfo: userInfo))
        }
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: OTMUdacityClient.tmdbURLFromWithoutParameters(withPathExtension: method))
        
        
        
        request.httpMethod = "Delete"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your Password or Email uncorrect!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range) 
            
            
            self.convertDataWithCompletionHandler(newData, decode: decode!, completionHandlerForConvertData: completionHandlerForDelete)
            
        }
        task.resume()
        
        return task
    }
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    
    private func convertDataWithCompletionHandler<D: Decodable>(_ data: Data,decode:D.Type, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        
        do {
            let obj = try JSONDecoder().decode(decode, from: data)
            completionHandlerForConvertData(obj as AnyObject, nil)
            
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
    }
    
    
    
    
    // create a URL from without parameters
    class func tmdbURLFromWithoutParameters( withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = OTMUdacityClient.Constants.ApiSchema
        components.host = OTMUdacityClient.Constants.ApiHost
        components.path = OTMUdacityClient.Constants.ApiPath + (withPathExtension ?? "")
        
        
        print("Udacity API: \(components.url!)")
        return components.url!
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> OTMUdacityClient {
        struct Singleton {
            static var sharedInstance = OTMUdacityClient()
        }
        return Singleton.sharedInstance
    }}
