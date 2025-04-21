//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 19/04/25.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)

}
