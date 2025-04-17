//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 15/04/25.
//

import Foundation
class MoviesLoader: MoviesLoading {
    
    private let networkClient: NetworkRouting
     
     init(networkClient: NetworkRouting = NetworkClient()) {
         self.networkClient = networkClient
     }
    
    var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, any Error>) -> Void) {
        print(mostPopularMoviesUrl)
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
                switch result {
                case .success(let data):
                    do {
                        let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                        handler(.success(mostPopularMovies))
                    } catch {
                        handler(.failure(error))
                    }
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        
    }
    
    
}
