//
//  Puntuacion.swift
//  Tare1
//
//  Created by user200902 on 08/11/2023.
//

import Foundation

class Score {
    var scoreValue: Int
    var date: Date // Nuevo campo para la fecha

    init(scoreValue: Int, date: Date = Date()) {
        self.scoreValue = scoreValue
        self.date = date
    }
}
