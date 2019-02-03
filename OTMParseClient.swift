//
//  OTMUParseClient.swift
//  onTheMap
//
//  Created by Hessah Saad on 23/04/1440 AH.
//  Copyright © 1440 Hessah Saad. All rights reserved.
//

import Foundation
class OTMUParseClient : NSObject {
    
    
    var session = URLSession.shared
    var objectId : String? = nil
    
    override init() {
        super.init()
    }
    func taskForGETMethod<D:Decodable>(_ method: String , parameters :[String:AnyObject], decode:D.Type , completionHandlerForGET: @escaping(_ result : AnyObject? , _ error: NSError?)-> Void) -> URLSessionDataTask {
        var parameterWithApiKey = parameters
        var request = NSMutableURLRequest(url: tmdbURLFromParameters (parameterWithApiKey , withBathExtention : method))
        
        request.addValue(OTMUParseClient.Constants.ApplicationID , forHTTPHeaderField: "X-Parse-Application-Id")
         request.addValue(OTMUParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
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
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("there is no data ")
                return
            }
            self.convertDataWithCompletionHandler(data, decode: decode, completionHandlerForConvertData: completionHandlerForGET)
            
            
        }
        task.resume()
        return task
       
        
    }
    func taskForPOSTMethod<E:Encodable,D:Decodable>(_ method : String , decode : D.Type? , jsonBody : E ,completionHandlerForPOST:@escaping(_ result : AnyObject? , _ error: NSError?)-> Void) -> URLSessionDataTask {
        func sendError(_ error:String){
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForPOST(nil , NSError(domain: "task for post Method", code: 1, userInfo: userInfo))
        }
        let request = NSMutableURLRequest(url:tmdbURLFromWithoutParameters(withPathExtention : method))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(OTMUParseClient.Constants.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(OTMUParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
    
        do{
            let JsonBody = try JSONEncoder().encode(jsonBody)
            request.httpBody = JsonBody
        }catch{
            sendError("there was an error \(error)")
        }
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("\(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            self.convertDataWithCompletionHandler(data, decode: decode!, completionHandlerForConvertData:completionHandlerForPOST )
        
    }
        task.resume()
        return task
    
    }
    func taskForPUTMethod<E:Encodable,D:Decodable>(_ method : String , decode : D.Type? , jsonBody : E ,completionHandlerForPUT:@escaping(_ result : AnyObject? , _ error: NSError?)-> Void) -> URLSessionDataTask {
        func sendError(_ error:String){
            print(error)
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForPUT(nil , NSError(domain: "task for put Method", code: 1, userInfo: userInfo))
        }
        let request = NSMutableURLRequest(url:tmdbURLFromWithoutParameters(withPathExtention : method))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(OTMUParseClient.Constants.ApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(OTMUParseClient.Constants.ApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
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
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            self.convertDataWithCompletionHandler(data, decode: decode!, completionHandlerForConvertData:completionHandlerForPUT )
            
        }
        task.resume()
        return task
        
    }
    func substituteKeyInMethod(_ method :String , key : String ,value : String)->String?{
        if method.range(of: "{\(key)}") != nil{
            return method.replacingOccurrences(of:( "{\(key)}"), with: value)
        }
        else {
            return nil
        }
        
    }
    
    private func convertDataWithCompletionHandler<D:Decodable>(_ data : Data , decode: D.Type ,completionHandlerForConvertData : (_ result : AnyObject?, _ error :NSError?)-> Void){
        do{
            
          let obj = try JSONDecoder().decode(decode, from: data)
            completionHandlerForConvertData(obj as AnyObject, nil)
            
        }
        catch {
    let userInfo = [NSLocalizedDescriptionKey:"Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil , NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
            }
    }
    
    private func tmdbURLFromParameters(_ parameters : [String:AnyObject],withBathExtention : String? = nil)->URL{
        var components = URLComponents()
        components.scheme = OTMUParseClient.Constants.ApiScheme
        components.host = OTMUParseClient.Constants.ApiHost
        components.path = OTMUParseClient.Constants.ApiPath + (withBathExtention ?? " ")
        components.queryItems = [URLQueryItem]()
        for (key , value) in parameters {
            let queryItem = URLQueryItem (name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        let url  :URL?
        let urlString = components.url!.absoluteString
        if urlString.contains("%22:"){
            url = URL(string : "\(urlString.replacingOccurrences(of: "%22:", with: "%22%3A"))")
            
        } else if urlString.contains("%20") {
            url = URL(string : "\(urlString.replacingOccurrences(of: "%20", with: ""))")
        }
        else {
            url = components.url!
        }
        return url!
    }
     private func tmdbURLFromWithoutParameters(withPathExtention : String? = nil)->URL{
        var components = URLComponents()
        components.scheme = OTMUParseClient.Constants.ApiScheme
        components.host = OTMUParseClient.Constants.ApiHost
        components.path = OTMUParseClient.Constants.ApiPath + (withPathExtention ?? " ")
        print(components.url!)
        return components.url!
    }
    class func sharedInstance()->OTMUParseClient{
        struct Singleton{
            static var sharedInstance = OTMUParseClient()
        }
        return Singleton.sharedInstance
    }
    
}

