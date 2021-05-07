//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Myles Cashwell on 5/7/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var arrowRating: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Functions
    func updateViews() {
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.title
        movieDescriptionLabel.text = movie.description
        
        movieRatingLabel.text = "Rating: \(movie.rating)"
        if movie.rating > 7.00 {
            arrowRating.image = UIImage(systemName: "arrowtriangle.up.circle")
            arrowRating.tintColor = .green
        } else {
            arrowRating.image = UIImage(systemName: "arrowtriangle.down.circle")
            arrowRating.tintColor = .red
        }
        
        MovieController.fetchMoviePoster(for: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let poster):
                    self.moviePosterImageView.image = poster
                case .failure(let error):
                    self.moviePosterImageView.image = UIImage(named: "movieReel")
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
