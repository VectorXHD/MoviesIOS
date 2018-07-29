//
//  API.swift
//  Movie
//
//  Created by VectorXHD on 29/07/2018.
//  Copyright © 2018 VectorXHD. All rights reserved.
//

import Foundation
import Moya

class API {
    static let provider = MoyaProvider<MovieApi>()
    static let apiKey: String = "**APIKEY**"
    static let format: String = "json"
    
    static func getMovies(completion: @escaping ([Movie]) -> Void) {
        provider.request(.movies) { (result) in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APIResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        provider.request(.moviesSearch(filter: query)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APIResult.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
