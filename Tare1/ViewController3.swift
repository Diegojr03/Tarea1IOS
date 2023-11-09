//
//  ViewController3.swift
//  Tare1
//
//  Created by user200902 on 08/11/2023.
//

import UIKit

class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate {
        @IBOutlet weak var tableView: UITableView!
        var scores: [Score] = []
        var puntuacionActual: Int = 0  // Nueva propiedad para almacenar la puntuación actual

        override func viewDidLoad() {
            super.viewDidLoad()

            // Configurar la tabla
            tableView.dataSource = self
            tableView.delegate = self

            // Agregar la puntuación actual antes de reiniciarla
            if puntuacionActual > 0 {
                let score = Score(scoreValue: puntuacionActual)
                scores.append(score)
            }

            // Ordenar las puntuaciones de mayor a menor
            scores.sort { $0.scoreValue > $1.scoreValue }

            // Recargar la tabla después de actualizar los datos
            tableView.reloadData()
        }

        // Implementar métodos del protocolo UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return scores.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)

            let score = scores[indexPath.row]
            cell.textLabel?.text = "\(score.scoreValue) puntos"

            return cell
        }
}
