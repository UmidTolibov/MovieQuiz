//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 15/04/25.
//

import Foundation

protocol StatisticServiceProtocol {
    
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}
