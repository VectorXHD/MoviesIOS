//
//  MovieApi.swift
//  Movie
//
//  Created by VectorXHD on 29/07/2018.
//  Copyright © 2018 VectorXHD. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case movies
    case moviesSearch(filter: String)
}

extension MovieApi: TargetType {
    var baseURL: URL { return URL(string: "https://comicvine.gamespot.com/api/")! }
    
    var path: String {
        switch self {
        case .movies, .moviesSearch: return "movies"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movies, .moviesSearch: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .movies: return ["api_key": API.apiKey, "format": API.format]
        case .moviesSearch(let filter): return ["api_key": API.apiKey, "format": API.format, "filter": "name:\(filter)"]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .movies, .moviesSearch: return URLEncoding.queryString
        }
    }
    
    var sampleData: Data {
        switch self {
        case .movies, .moviesSearch: return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .movies, .moviesSearch: return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
