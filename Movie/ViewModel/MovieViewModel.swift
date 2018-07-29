//
//  MovieViewModel.swift
//  Movie
//
//  Created by VectorXHD on 29/07/2018.
//  Copyright © 2018 VectorXHD. All rights reserved.
//

import UIKit

protocol MoviesSearchRepositoriesDelegate {
    func searchResultsDidChanged()
}

class MovieViewModel: NSObject {

    var delegate: MoviesSearchRepositoriesDelegate?
    var movies: [Movie]?
        
    func fetchMovies() {
        API.getMovies { (movies) in
            self.movies = movies
            self.delegate?.searchResultsDidChanged()
        }
    }
    
    func searchMovies(query: String) {
        API.searchMovies(query: query) { (movies) in
            self.movies = movies
            self.delegate?.searchResultsDidChanged()
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func titleForItemAtIndexPath(indexPath: IndexPath) -> String {
        return movies?[indexPath.row].name ?? ""
    }
    
}
