	//
//  ViewController.swift
//  Tare1
//
//  Created by user200902 on 07/11/2023.
//

import UIKit

class ViewController: UIViewController {

    
        var aciertos: Int = 0
        var totalImagenes: Int = 4
        // Son las imagenes de los equipos de la NBA en el viewController
        @IBOutlet weak var imageView1: UIImageView!
        @IBOutlet weak var imageView2: UIImageView!
        @IBOutlet weak var imageView3: UIImageView!
        @IBOutlet weak var imageView4: UIImageView!

        
        @IBOutlet weak var squareView1: UIView!
        @IBOutlet weak var squareView2: UIView!
        @IBOutlet weak var squareView3: UIView!
        @IBOutlet weak var squareView4: UIView!

        var originalPositions: [CGPoint] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            // Guardar las posiciones originales al cargar la vista
            originalPositions = [
                imageView1.frame.origin,
                imageView2.frame.origin,
                imageView3.frame.origin,
                imageView4.frame.origin
            ]

            // Configurar la propiedad isUserInteractionEnabled en true
            imageView1.isUserInteractionEnabled = true
            imageView2.isUserInteractionEnabled = true
            imageView3.isUserInteractionEnabled = true
            imageView4.isUserInteractionEnabled = true

            // Agregar gesto de arrastre a cada imagen
            addTapGesture(to: imageView1, tag: 1)
            addTapGesture(to: imageView2, tag: 2)
            addTapGesture(to: imageView3, tag: 3)
            addTapGesture(to: imageView4, tag: 4)
        }

    func addTapGesture(to view: UIView, tag: Int) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
            view.tag = tag
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let tappedView = gesture.view else { return }
            moveImageToPosition(tappedView)
        }

        func moveImageToPosition(_ tappedView: UIView) {
            guard tappedView.tag <= totalImagenes else { return }

            let squareView: UIView?
            switch tappedView.tag {
                case 1:
                    squareView = squareView1
                case 2:
                    squareView = squareView2
                case 3:
                    squareView = squareView3
                case 4:
                    squareView = squareView4
                default:
                    squareView = nil
            }

            if let squareView = squareView {
                UIView.animate(withDuration: 0.5) {
                    tappedView.frame.origin = squareView.frame.origin
                }

                // Verificar si la imagen está en su posición correcta
                checkMatchingSquare(for: tappedView)
            }
        }

        func checkMatchingSquare(for imageView: UIView) {
            let squareView: UIView?
            switch imageView.tag {
                case 1:
                    squareView = squareView1
                case 2:
                    squareView = squareView2
                case 3:
                    squareView = squareView3
                case 4:
                    squareView = squareView4
                default:
                    squareView = nil
            }

            if let squareView = squareView {
                let imageViewFrameInSquareView = squareView.convert(imageView.frame, from: imageView.superview)

                if imageViewFrameInSquareView.intersects(squareView.bounds) {
                    // Si hay intersección, cuenta como un acierto
                    aciertos += 1
                    print("¡Acierto! Nuevo total de aciertos: \(aciertos)")
                } else {
                    // La imagen no está en su posición correcta
                    print("Posición incorrecta")
                }
            }
        }

        @IBAction func PasarPantalla(_ sender: Any) {
            // Utiliza solo performSegue para realizar la transición
            performSegue(withIdentifier: "ViewController2", sender: self)
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
            // Mover las imágenes a posiciones específicas
            let centerY = view.frame.height / 2 + 100  // Mitad de la pantalla más 100 puntos hacia abajo
            let positions = [
                CGPoint(x: 50, y: centerY),
                CGPoint(x: 120, y: centerY),
                CGPoint(x: 190, y: centerY),
                CGPoint(x: 260, y: centerY)
            ]

            let imageViews = [imageView1, imageView2, imageView3, imageView4]

            for (index, imageView) in imageViews.enumerated() {
                if let unwrappedImageView = imageView, index < positions.count {
                    let newPosition = positions[index]
                    unwrappedImageView.frame.origin = newPosition
                }
            }
        }
}

