import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    
    @IBOutlet weak var QuestionTitleLabel: UILabel!
    
    @IBOutlet weak var PreviewImage: UIImageView!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var NoButton: UIButton!
    
    @IBOutlet weak var YesButton: UIButton!
    
    @IBOutlet private var imageView: UIImageView!

    @IBOutlet private var counterLabel: UILabel!
    
    @IBOutlet private var textLabel: UILabel!
    
    private var currentQuestionIndex = 0

    private var correctAnswers = 0
    
    var currentQuestion:QuizStepViewModel! {
        didSet {
            updateUI()
        }
    }
    
    
    private var questions: [QuizQuestion] = [ QuizQuestion(
        image: "The Godfather",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "The Dark Knight",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "Kill Bill",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "The Avengers",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "Deadpool",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "The Green Knight",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
    QuizQuestion(
        image: "Old",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
    QuizQuestion(
        image: "The Ice Age Adventures of Buck Wild",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
    QuizQuestion(
        image: "Tesla",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
    QuizQuestion(
        image: "Vivarium",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false)]
    
    var viewModel =  QuizStepViewModel(image: UIImage(), question: "", questionNumber: "", correctAnswer: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
       
        
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)",
            correctAnswer: model.correctAnswer)
        return questionStep
    }
    
    
    private func updateUI() {
        if currentQuestionIndex >= questions.count {
            currentQuestionIndex = 0
        }
        let currentQuestion = questions[currentQuestionIndex]
         viewModel = convert(model: currentQuestion)
        textLabel.text = viewModel.question
        imageView.image = viewModel.image
        counterLabel.text = viewModel.questionNumber
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        
        if viewModel.correctAnswer == true {
            correctAnswers+=1
        }
        currentQuestionIndex += 1
        updateUI()
    }

    
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        if viewModel.correctAnswer == false {
            correctAnswers+=1
        }
        currentQuestionIndex += 1
        updateUI()
  
    }
    
    
}

struct QuizQuestion {
    let image:String
    let text:String
    let correctAnswer:Bool
    
}

struct QuizStepViewModel{
    let image: UIImage
    let question: String
    let questionNumber: String
    let correctAnswer:Bool
}
/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
