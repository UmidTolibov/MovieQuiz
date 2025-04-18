//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 15/04/25.
//

import Foundation

struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetter(than other: GameResult) -> Bool {
         correct > other.correct
    }
}
