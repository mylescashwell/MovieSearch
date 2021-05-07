//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Myles Cashwell on 5/7/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    //MARK: - Properties
    var movies: [Movie] = []
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

//MARK: - Extensions
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        MovieController.fetchSearchedMovie(searchedMovie: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
