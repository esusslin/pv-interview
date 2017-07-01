//
//  NetworkManager.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let myCompletionHandler: (Data?, URLResponse?, Error?) -> Void = {
        (data, response, error) in
        // this is where the completion handler code goes
        if let response = response {
            print(response)
        }
        if let error = error {
            print(error)
        }
    }
    

    
    func getTopRated() {
        //set up url request
        let urlString = Constants.fight_club_url
        
        
        print("made it here")
        
        guard let url = URL(string: urlString) else {
            print("connot convert url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        //set up session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //make request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            do {
                
                guard error == nil else {
                    print("error")
                    return
                }
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                print("we got some data")
                
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                print("no errors")
               // print(todo["title"] as? String)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
        })
        
        task.resume()
        
    }

    
    
    
    
    
    func getTopRated() -> String {
        //set up url request
        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=4e5ae41d4d6af54849229c5da8960317"
        
        var responseString: String = "000"
       
        
        guard let url = URL(string: urlString) else {
            responseString = "connot convert url"
            return "Cannot convert url"
        }
        
        let urlRequest = URLRequest(url: url)
        
        //set up session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //make request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            do {

                guard error == nil else {
                    responseString = "error"
                    return
                }
                
                guard data == nil else {
                    responseString = "error with data"
                    return
                }
                
                responseString = "we got some data"
                
                guard let todo = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else {
                    responseString = "error trying to convert data to JSON"
                    return
                    }
                
                responseString = todo["title"] as! String
                
            } catch  {
                responseString = "error trying to convert data to JSON"
                return
            }
            
        })
        
        task.resume()
        
       // responseString = "111"
        
        return responseString
    }
}
