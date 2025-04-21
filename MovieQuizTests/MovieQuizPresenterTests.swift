//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Tolibov Umidjon Izomovich on 21/04/25.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizPresenterTests: XCTestCase {
    
    final class MovieQuizPresenterTests: XCTestCase {
        
        func testConvertModel() throws {
            // given
            let mockViewController = MovieQuizViewControllerMock()
            let presenter = MovieQuizPresenter(viewController: mockViewController)
            
            let imageData = UIImage(named: "PosterStub")!.pngData()!
            let question = QuizQuestion(
                image: imageData,
                text: "Is this movie released in 1972?",
                correctAnswer: true
            )
            presenter.currentQuestionIndex = 0
       
            // when
            let viewModel = presenter.convert(model: question)
            
            // then
            XCTAssertEqual(viewModel.question, "Is this movie released in 1972?")
            XCTAssertEqual(viewModel.questionNumber, "1/10")
            XCTAssertNotNil(viewModel.image)
        }
    }
}

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func show(quiz step: QuizStepViewModel) {}
    func show(quiz result: QuizResultsViewModel) {}
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    func showLoadingIndicator() {}
    func hideLoadingIndicator() {}
    func showNetworkError(message: String) {}
}
