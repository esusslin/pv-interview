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
    
    func didReceiveMovie(results: FullMovieModel)
    
}

var dict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Config", ofType: "plist")!)

class Api {
  
    var delegate: APIControllerProtocol?
    
    init(delegate: APIControllerProtocol?) {
        self.delegate = delegate
    }
    typealias APICallback = ((NSDictionary?, NSString?) -> ())
    typealias DownloadCallback = ((Data?, NSString?) -> ())
    typealias MovieCallback = ((FullMovieModel?, NSString?) -> ())
    //typealias genreCallback = ((String?) -> ())
    
    
    func getTopRatedMovies(page: Int, callback: @escaping APICallback) {
        let urlObject = URL(string: Constants.top_rated_url + String(page))
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
    
    
    func downloadLargeImage(url: String, callback: @escaping DownloadCallback) {
        let fullUrl = Constants.image_base_url + "/w780" + url
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
    
    
    func getMovie(movieId: Int, callback: @escaping MovieCallback) {
        let id: String = String(movieId)
        let fullUrl = Constants.movie_detail_url + id + "?api_key=" + Constants.api_key
        
        let urlPath = URL(string: fullUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: urlPath!) { (data, response, error) -> Void in
            if error != nil {
                callback(nil, error?.localizedDescription as NSString?)
            } else {
               
                do {
                    guard let jsonResults = try JSONSerialization.jsonObject(with: data!, options: [])
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    if let movie = FullMovieModel(json: jsonResults) {
                        callback(movie, nil)
                        self.delegate?.didReceiveMovie(results: movie)
                    }
                    
                } catch  {
                    print("error with json")
                }
            }
    
        }
        task.resume()
    }
    
    //func getGenereForId(genreId: Int, callback: genreCallback)
}
