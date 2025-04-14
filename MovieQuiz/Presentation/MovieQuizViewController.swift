import UIKit

final class MovieQuizViewController: UIViewController , QuestionFactoryDelegate{
    
    
    // MARK: - Lifecycle
    
    @IBOutlet private var questionTitleLabel: UILabel!
    
    @IBOutlet private var previewImage: UIImageView!
    
    @IBOutlet private var questionLabel: UILabel!
    
    @IBOutlet private var noButton: UIButton!
    
    @IBOutlet private var yesButton: UIButton!
    
    @IBOutlet private var counterLabel: UILabel!
    
    private var currentQuestionIndex = 0
    
    private var correctAnswers = 0
    
    private let questionsAmount: Int = 10
    
    private var questionFactory: QuestionFactoryProtocol?
    
    private let alertPresenter: AlertPresenter? = nil
    
    private var currentQuestion: QuizQuestion?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let questionFactory = QuestionFactory()
            questionFactory.delegate = self
            self.questionFactory = questionFactory   
        if let firstQuestion  = questionFactory.requestNextQuestion() {
            let currentQuestion = firstQuestion
            let questionStepViewModel = convert(model: currentQuestion)
            show(quiz: questionStepViewModel)
        }
        
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStepViewModel = QuizStepViewModel(image:UIImage(named: model.image) ?? UIImage(),
                                                      question: model.text,
                                                      questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStepViewModel
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
            correctAnswers+=1
            previewImage.layer.borderColor = UIColor.ypGreen.cgColor
        }else{
            previewImage.layer.borderColor = UIColor.ypRed.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            let text = "Ваш результат: \(correctAnswers)/\(questionsAmount)"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            previewImage.layer.borderColor = UIColor.clear.cgColor
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert  = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText,
            completionHandler  : {
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
        guard let currentQuestion = currentQuestion else {
            return
        }
        showAnswerResult(isCorrect:currentQuestion.correctAnswer == true)
    }
    
    @IBAction private func noButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        showAnswerResult(isCorrect:currentQuestion.correctAnswer == false)
    }
}
