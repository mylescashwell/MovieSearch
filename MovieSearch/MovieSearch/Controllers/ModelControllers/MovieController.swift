//
//  MovieController.swift
//  MovieSearch
//
//  Created by Myles Cashwell on 5/7/21.
//

import UIKit

class MovieController {
    
    //MARK: - String Constants
    static let baseURL = URL(string: "https://api.themoviedb.org/")
    static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    static let versionComponent = "3"
    static let searchComponent = "search"
    static let movieComponent = "movie"
    static let apiKeyComponent = "api_key"
    static let apiKeyValue = "134356df717a98809e9d4dd9f1467597"
    
    
    //MARK: - Funtions
    static func fetchSearchedMovie(searchedMovie: String, completion: @escaping (Result<[Movie],SearchError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let versionURL = baseURL.appendingPathComponent(versionComponent)
        let searchURL = versionURL.appendingPathComponent(searchComponent)
        let movieURL = searchURL.appendingPathComponent(movieComponent)
        let movieQuery = URLQueryItem(name: "query", value: searchedMovie)
        let apiQuery = URLQueryItem(name: apiKeyComponent, value: apiKeyValue)
        
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [movieQuery, apiQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("MOVIE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movies = topLevelObject.results
                completion(.success(movies))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchMoviePoster(for movie: Movie, completion: @escaping (Result<UIImage, SearchError>) -> Void) {
        guard let movieImage = movie.image else { return completion(.failure(.invalidURL)) }
        guard let baseImageURL = baseImageURL else { return completion(.failure(.invalidURL)) }
        let moviePosterURL = baseImageURL.appendingPathComponent(movieImage)
        
        URLSession.shared.dataTask(with: moviePosterURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("MOVIE POSTER STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let moviePoster = UIImage(data: data) else { return completion(.failure(.noData)) }
            completion(.success(moviePoster))
        }.resume()
    }
}
