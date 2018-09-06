//
//  Movie.swift
//  projectTv
//
//  Created by William Doyle on 28/08/2018.
//  Copyright © 2018 William Doyle. All rights reserved.
//

import UIKit

struct Results: Decodable{
    let page: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

struct Movie: Decodable{
    let id:Int!
    let posterPath: String
    var videoPath: String?
    let backdrop: String
    let title: String
    var releaseDate: String
    var rating: Double
    let overview: String
    
    enum CodingKeys : String, CodingKey {
        case id, posterPath = "poster_path", videoPath = "video_path", backdrop, title, releaseDate = "release_date", rating, overview
    }
    
}
