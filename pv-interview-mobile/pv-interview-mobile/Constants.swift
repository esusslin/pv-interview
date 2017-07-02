//
//  File.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import Foundation

struct Constants {
    
    //unique key needed to access MovieDB
    static let api_key = "4e5ae41d4d6af54849229c5da8960317"

    
    //API endpoint to get array of top rated movies
    static let top_rated_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=4e5ae41d4d6af54849229c5da8960317&page="
    
    //API for testing getting a single move (Fight Club)
    static let fight_club_url = "https://api.themoviedb.org/3/movie/550?api_key=4e5ae41d4d6af54849229c5da8960317"
    
    //API for getting details about movie
    static let movie_detail_url = "https://api.themoviedb.org/3/movie/"
    
    static let image_base_url = "https://image.tmdb.org/t/p/"
    
    
    
}
