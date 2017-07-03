//
//  FullMovieModel.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/30/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import Foundation
class FullMovieModel {
    var title: String?
    var release_date: String?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var production: String?
    var genre: String?
    var budget: Int?
    var id: Int?

    //optional initializer used to parse json into a movieModel
    public init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let release_date = json["release_date"] as? String,
            let overview = json["overview"]  as? String,
            let posterPath = json["poster_path"] as? String,
            let backdropPath = json["backdrop_path"] as? String,
            let budget = json["budget"] as? Int,
            let id = json["id"] as? Int
        else {
            print("error parsing movie model")
            return nil
        }
    
        self.title = title
        self.release_date = release_date
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.budget = budget
        self.id = id
        
        guard let companies = json["production_companies"] as?  [[String: Any]] else {
                return nil
        }
        
        let production = companies.first?["name"] as? String
        self.production = production
        
        guard let genres = json["genres"] as? [[String: Any]] else {
            return nil
        }
        
        let genre = genres.first?["name"] as? String
        self.genre = genre

    }
}
