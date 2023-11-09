	//
//  ViewController.swift
//  Tare1
//
//  Created by user200902 on 07/11/2023.
//

import UIKit
import Foundation
    
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class ViewController: UIViewController {

    
    var aciertos: Int = 0
    var totalImagenes: Int = 4
    var imagenEnHueco: [UIView?] = [nil, nil, nil, nil]

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    @IBOutlet weak var squareView1: UIView!
    @IBOutlet weak var squareView2: UIView!
    @IBOutlet weak var squareView3: UIView!
    @IBOutlet weak var squareView4: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar la propiedad isUserInteractionEnabled en true
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true

        // Agregar reconocimiento de toques a cada imagen
        addTapGesture(to: imageView1)
        addTapGesture(to: imageView2)
        addTapGesture(to: imageView3)
        addTapGesture(to: imageView4)
    }

    func addTapGesture(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view else { return }
        moveImageToNextPosition(tappedView)
    }

    func moveImageToNextPosition(_ tappedView: UIView) {
        guard let index = imagenEnHueco.firstIndex(where: { $0 == nil}) else { return }

        let squareView: UIView?

        switch index {
            case 0:
                squareView = squareView1
            case 1:
                squareView = squareView2
            case 2:
                squareView = squareView3
            case 3:
                squareView = squareView4
            default:
                squareView = nil
        }

        if let squareView = squareView {
            UIView.animate(withDuration: 0.5) {
                tappedView.frame.origin = squareView.frame.origin
            }

                imagenEnHueco[index] = tappedView

                // Verificar si la imagen está en su posición correcta
                checkMatchingSquare(for: tappedView)
            }
        }

    func checkMatchingSquare(for imageView: UIView) {
        guard let index = imagenEnHueco.firstIndex(where: { $0 == imageView }) else { return }

        let expectedOrder = [imageView1, imageView2, imageView3, imageView4]

        if let correctImageView = expectedOrder[index],
           let currentImageView = imagenEnHueco[index],
            correctImageView == currentImageView {

            // La imagen está en su posición correcta
            print("¡Acierto! Nuevo total de aciertos: \(aciertos)")
            aciertos += 1

        } else {
            // La imagen no está en su posición correcta
            print("Posición incorrecta")
        }
    }


    @IBAction func PasarPantalla(_ sender: Any) {
        // Guardar la puntuación antes de realizar la transición
        guardarPuntuacion()

        // Utilizar solo performSegue para realizar la transición
        performSegue(withIdentifier: "ViewController2", sender: self)
    }
    
    func guardarPuntuacion() {
        // Configura el resultado del juego en el destino (ViewController2)
        if let destinoViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as? ViewController2 {
            destinoViewController.resultadoJuego = "\(aciertos)/\(totalImagenes), has acertado \(aciertos)"
                
            // Presenta el ViewController2 de manera modal
            present(destinoViewController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewController2" {
                // Configura el resultado del juego en el destino (ViewController2)
            if let destinoViewController = segue.destination as? ViewController2 {
                destinoViewController.resultadoJuego = "\(aciertos)/\(totalImagenes), has acertado \(aciertos)"
            }
        }
    }

    @IBAction func EmpezarJuego(_ sender: Any) {
        // Reiniciar la puntuación y mover las imágenes a posiciones específicas
            aciertos = 0

            let centerY = view.frame.height / 2 + 100
            let positions = [
                CGPoint(x: 190, y: centerY),
                CGPoint(x: 100, y: centerY),
                CGPoint(x: 20, y: centerY),
                CGPoint(x: 280, y: centerY)
            ]

            let imageViews = [imageView1, imageView2, imageView3, imageView4]

            for (index, imageView) in imageViews.enumerated() {
                if let unwrappedImageView = imageView, index < positions.count {
                    let newPosition = positions[index]
                    unwrappedImageView.frame.origin = newPosition
                    imagenEnHueco[index] = nil
                }
            }
        }
}

