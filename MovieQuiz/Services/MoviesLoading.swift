//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 15/04/25.
//

import Foundation

protocol MoviesLoading {
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}
