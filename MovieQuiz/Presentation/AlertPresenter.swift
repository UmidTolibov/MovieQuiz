//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 14/04/25.
//

import Foundation
import UIKit

final class AlertPresenter {
    weak var delegate: UIViewController?
    
    func show(alert model: AlertModel) {
        let alert = UIAlertController(title: model.title,
                                      message: model.message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completionHandler()
        }
        alert.addAction(action)
        
        delegate?.present(alert, animated: true, completion: nil)
    }
}
