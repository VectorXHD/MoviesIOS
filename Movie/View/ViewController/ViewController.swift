//
//  ViewController.swift
//  Movie
//
//  Created by VectorXHD on 29/07/2018.
//  Copyright © 2018 VectorXHD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate  {

    var searchText: String?
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var movieViewModel: MovieViewModel!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.startloading()
        movieViewModel.delegate = self
        moviesSearchBar.delegate = self
        moviesSearchBar.returnKeyType = UIReturnKeyType.done
        refreshControl.addTarget(self, action: #selector(refreshMoviesList), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        movieViewModel.fetchMovies()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        cell.textLabel?.text = movieViewModel.titleForItemAtIndexPath(indexPath: indexPath)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        self.startloading()
        self.searchText = searchBar.text
        
        refreshMoviesList()
    }
    
    @objc func refreshMoviesList() {
        if searchText != "" && searchText != nil {
            movieViewModel.searchMovies(query: searchText!)
        } else {
            movieViewModel.fetchMovies()
        }
    }
    
    //MARK: Loading Utils
    func startloading()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }

    func stopLoading()
    {
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

extension ViewController: MoviesSearchRepositoriesDelegate {
    func searchResultsDidChanged() {
        self.moviesTableView.reloadData()
        self.stopLoading()
    }
}
