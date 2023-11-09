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

            // Registro de la celda con el identificador "ScoreCell"
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")

            // Añadir varias puntuaciones para propósitos de prueba
            scores.append(Score(scoreValue: 4, date: Date()))

            // Llamar al método para ordenar y recargar la tabla
            updateTable()

            // Imprimir para verificar si se agregan las puntuaciones
            print("Puntuaciones actuales: \(scores)")
        }

        // Implementar métodos del protocolo UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Imprimir para verificar la cantidad de filas en la tabla
            print("Número de filas en la tabla: \(scores.count)")
            return scores.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)

            let score = scores[indexPath.row]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Puedes ajustar el formato según tus preferencias
            let dateString = dateFormatter.string(from: score.date)

            cell.textLabel?.text = "\(score.scoreValue) puntos - \(dateString)"

            return cell
        }
    
        func updateTable() {
            // Ordenar las puntuaciones de mayor a menor
            scores.sort { $0.scoreValue > $1.scoreValue }

            // Recargar la tabla después de actualizar los datos
            tableView.reloadData()

            // Imprimir para verificar si se ejecuta
            print("Tabla actualizada. Puntuaciones: \(scores)")
        }
}
