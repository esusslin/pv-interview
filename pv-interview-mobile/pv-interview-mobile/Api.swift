//
//  Api.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import Foundation
import UIKit

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary?)
    
    func didReceiveImageResults(results: Data?)
    
}

var dict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Config", ofType: "plist")!)

class Api {
  
    var delegate: APIControllerProtocol?
    
    init(delegate: APIControllerProtocol?) {
        self.delegate = delegate
    }
    typealias APICallback = ((NSDictionary?, NSString?) -> ())
    typealias DownloadCallback = ((Data?, NSString?) -> ())
    
    
    func getTopRatedMovies(callback: @escaping APICallback) {
        let urlObject = URL(string: Constants.top_rated_url)
        let request = URLRequest(url: urlObject!)
        
        httpRequest (request: request) {
            (data, error) -> Void in
            callback(data, error)
            self.delegate?.didReceiveAPIResults(results: data)
        }
    }
    
    func httpRequest(request: URLRequest!, callback: @escaping APICallback) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            if error != nil {
                callback(nil, error?.localizedDescription as NSString?)
            } else {
                do {
                    guard let jsonResults = try JSONSerialization.jsonObject(with: data!, options: [])
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                   //print(jsonResults)
                   callback(jsonResults as NSDictionary?, nil)
                    
                } catch  {
                    print("error with json")
                }
            }
            
        }
        task.resume()
    }
    
    func downloadImage(url: String, callback: @escaping DownloadCallback) {
        let fullUrl = Constants.image_base_url + "/w154" + url
        let urlPath = URL(string: fullUrl)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlPath!) { (data, response, error) -> Void in
            if error != nil {
                callback(nil, error?.localizedDescription as NSString?)
            } else {
                callback(data, nil)
            }
        }
        task.resume()
    }
    
    //func getMovie(movieId: String, callback:)
}
