# Tarea1IOS

## Descripción
Este proyecto trata de un juego de memoria en el que hay que dejas las imagenes colocadas en el mismo sitio que estaban antes de darle a jugar

## Pantallas
- [x] Primera pantalla hecha
- [x] Segunda pantalla hecha
- [x] Tercera pantalla hecha

### Funcion más complicada (en mi opinion) de la primera pantalla

```swift
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
```
