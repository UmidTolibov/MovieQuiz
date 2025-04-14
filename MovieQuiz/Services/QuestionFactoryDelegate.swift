//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 13/04/25.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
