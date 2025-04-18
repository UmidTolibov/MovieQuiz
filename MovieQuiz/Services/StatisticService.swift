//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 15/04/25.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    
    private enum Keys {
        static let correct = "correct"
        static let total = "total"
        static let bestGame = "bestGame"
        static let gamesCount = "gamesCount"
    }
    
    private let userDefaults = UserDefaults.standard
    
    var totalAccuracy: Double {
        let correct = userDefaults.integer(forKey: Keys.correct)
        let total = userDefaults.integer(forKey: Keys.total)
        guard total > 0 else { return 0.0 }
        return (Double(correct) / Double(total)) * 100
    }
    
    var gamesCount: Int {
        get { userDefaults.integer(forKey: Keys.gamesCount) }
        set { userDefaults.set(newValue, forKey: Keys.gamesCount) }
    }
    
    var bestGame: GameResult {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame),
                  let game = try? JSONDecoder().decode(GameResult.self, from: data) else {
                return GameResult(correct: 0, total: 0, date: Date())
            }
            return game
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: Keys.bestGame)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        userDefaults.set(userDefaults.integer(forKey: Keys.correct) + count, forKey: Keys.correct)
        userDefaults.set(userDefaults.integer(forKey: Keys.total) + amount, forKey: Keys.total)
        gamesCount += 1
        let currentGame = GameResult(correct: count, total: amount, date: Date())
        if currentGame.isBetter(than: bestGame) {
            bestGame = currentGame
        }
    }
}
