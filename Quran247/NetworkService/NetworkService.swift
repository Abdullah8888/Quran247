//
//  NetworkService.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 13/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public class NetworkService: NSObject {
    
    //A singleton object
    public static let sharedManager = NetworkService()
    
    public func getAllReciters(completion: @escaping (_ success: Bool, _ object: SwiftyJSON.JSON?, _ response: URLResponse) -> ()) {
        
        let urlString = "https://dawahnigeria.com/dn_qs.json"
        let request = self.createRequest(urlString: urlString)

        post(request: request) { (success, object, response) in
            completion(success, object, response)
        }
    }
    
  //MARK: Convenience Methods
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: SwiftyJSON.JSON?, _ response: URLResponse) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default);
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let error = error {
                print("the error now is \(error.localizedDescription)")
            }
            
            if let data = data {
                let obj = try? JSON(data: data)
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, obj, response)
                } else {
                    completion(false, obj, response!)
                }
            }
            }.resume();
    }
    
    
    private func createRequest(urlString: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("", forHTTPHeaderField: "User-Agent")
        return request
    }
    
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: SwiftyJSON.JSON?, _ response: URLResponse) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: SwiftyJSON.JSON?, _ response: URLResponse) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
}
