//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Tolibov Umidjon Izomovich on 14/04/25.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completionHandler: () -> Void
}
