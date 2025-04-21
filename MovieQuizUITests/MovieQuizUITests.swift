//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Tolibov Umidjon Izomovich on 17/04/25.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        // это специальная настройка для тестов: если один тест не прошёл,
        // то следующие тесты запускаться не будут; и правда, зачем ждать?
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    @MainActor
    func testYesButton() throws {
        sleep(3)
        
        let firstPoster  = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["Yes"].tap()
        sleep(3)
        
        let secondPoster  = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        
    }
    
    
    func testNoButton() throws {
        sleep(3)
        
        let firstPoster  = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["No"].tap()
        sleep(3)
        
        let secondPoster  = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        let indexLabel  = app.staticTexts["Index"]
        XCTAssertEqual(indexLabel.label, "2/10")
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
    }
    
    func testGameFinish() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        let resultTitle = app.staticTexts["Этот раунд окончен!"]
        let playAgainButton = app.buttons["Сыграть ещё раз"]
        
        XCTAssertTrue(resultTitle.waitForExistence(timeout: 5), "Заголовок результата не появился")
        XCTAssertTrue(playAgainButton.waitForExistence(timeout: 5), "Кнопка 'Сыграть ещё раз' не появилась")
        
    }
    
    func testAlertDismiss() {
        for _ in 1...10 {
             app.buttons["No"].tap()
             sleep(1)
         }

         let resultTitle = app.staticTexts["Этот раунд окончен!"]
         let playAgainButton = app.buttons["Сыграть ещё раз"]

         XCTAssertTrue(resultTitle.waitForExistence(timeout: 5), "Алерт не появился")
         XCTAssertTrue(playAgainButton.exists)

         playAgainButton.tap()

         // Ждём, пока алерт исчезнет
         XCTAssertFalse(resultTitle.waitForExistence(timeout: 3))
         XCTAssertFalse(playAgainButton.exists)

         let indexLabel = app.staticTexts["Index"]
         XCTAssertTrue(indexLabel.waitForExistence(timeout: 5), "Лейбл с номером вопроса не появился")
         XCTAssertEqual(indexLabel.label, "1/10")
        
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
