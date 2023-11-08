//
//  ViewController2.swift
//  Tare1
//
//  Created by user200902 on 07/11/2023.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var CampoResultado: UILabel!
    var resultadoJuego: String?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Configurar tu etiqueta de texto con el resultadoJuego
            CampoResultado.text = resultadoJuego
        }
   

}
