//
//  Movie.swift
//  Movie
//
//  Created by VectorXHD on 29/07/2018.
//  Copyright © 2018 VectorXHD. All rights reserved.
//

import Foundation

struct APIResult: Decodable {
    let numberOfPageResult: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case numberOfPageResult = "number_of_page_results", movies = "results"
    }
}

struct Movie: Decodable {
    let id: Int!
    let name: String!
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
