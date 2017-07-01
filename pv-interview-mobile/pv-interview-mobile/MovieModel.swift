//
//  MovieModel.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import Foundation

class MovieModel {
    var title: String?
    var release_date: String?
    var overview: String?
    var posterPath: String?
    var id: Int?
    
    //optional initializer used to parse json into a movieModel
    public init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let release_date = json["release_date"] as? String,
            let overview = json["overview"]  as? String,
            let posterPath = json["poster_path"] as? String,
            let id = json["id"] as? Int
        else {
            print("error parsing movie model")
                return nil
        }
        
        self.title = title
        self.release_date = release_date
        self.overview = overview
        self.posterPath = posterPath
        self.id = id
    }
}
