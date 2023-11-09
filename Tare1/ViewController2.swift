//
//  ViewController2.swift
//  Tare1
//
//  Created by user200902 on 07/11/2023.
//

import UIKit
import Foundation

class ViewController2: UIViewController {

    @IBOutlet weak var CampoResultado: UILabel!
        var resultadoJuego: String?
        var puntuacionActual: Int = 0  // Nueva propiedad para almacenar la puntuación actual

        override func viewDidLoad() {
            super.viewDidLoad()

            // Configurar tu etiqueta de texto con el resultadoJuego
            CampoResultado.text = resultadoJuego

            // Convertir el resultadoJuego a una puntuación actual
            if let resultadoJuego = resultadoJuego {
                let aciertos = resultadoJuego.components(separatedBy: "/")
                if let aciertosNumeric = Int(aciertos.first ?? "") {
                    puntuacionActual = aciertosNumeric
                }
            }
        }
}
