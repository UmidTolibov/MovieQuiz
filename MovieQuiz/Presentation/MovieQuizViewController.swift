import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
    
    @IBOutlet private var questionTitleLabel: UILabel!
    @IBOutlet private var previewImage: UIImageView!
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var counterLabel: UILabel!
    
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount = 10
    private var questionFactory: QuestionFactoryProtocol?
    private let statisticService: StatisticServiceProtocol = StatisticService()
    private let alertPresenter: AlertPresenter? = AlertPresenter()
    private var currentQuestion: QuizQuestion?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        let questionFactory = QuestionFactory()
        questionFactory.delegate = self
        alertPresenter?.delegate = self
        self.questionFactory = questionFactory
        questionFactory.requestNextQuestion()

    }
    
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
        )
    }
    
    private func show(quiz step: QuizStepViewModel) {
        yesButton.isEnabled = true
        noButton.isEnabled = true
        previewImage.layer.borderColor = UIColor.clear.cgColor
        previewImage.image = step.image
        questionLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        previewImage.layer.masksToBounds = true
        previewImage.layer.borderWidth = 8
        if isCorrect {
            correctAnswers += 1
            previewImage.layer.borderColor = UIColor.ypGreen.cgColor
        } else {
            previewImage.layer.borderColor = UIColor.ypRed.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            
            let bestGame = statisticService.bestGame
            let gamesCount = statisticService.gamesCount
            let totalAccuracy = String(format: "%.2f", statisticService.totalAccuracy)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            let text = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Кол-во сыгранных квизов: \(gamesCount)
            Рекорд: \(bestGame.correct)/\(bestGame.total) (\(dateFormatter.string(from: bestGame.date)))
            Средняя точность: \(totalAccuracy)%
            """
            
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз"
            )
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            previewImage.layer.borderColor = UIColor.clear.cgColor
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText,
            completionHandler: {
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.questionFactory?.requestNextQuestion()
            }
        )
        alertPresenter?.show(alert: alert)
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    @IBAction private func yesButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        guard let currentQuestion = currentQuestion else { return }
        showAnswerResult(isCorrect: currentQuestion.correctAnswer)
    }
    
    @IBAction private func noButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        guard let currentQuestion = currentQuestion else { return }
        showAnswerResult(isCorrect: !currentQuestion.correctAnswer)
    }
}
