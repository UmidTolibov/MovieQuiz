//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 14/04/25.
//

import Foundation
import UIKit
final class AlertPresenter {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func show(alert model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completionHandler()
        }
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
