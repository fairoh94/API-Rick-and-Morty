import Foundation
import Kingfisher

// Extensión de UIImageView para simplificar la carga de imágenes utilizando Kingfisher
extension UIImageView {
    // Función que establece la imagen de UIImageView desde una URL utilizando Kingfisher
    func setImage(imageUrl: String) {
        // Utiliza Kingfisher para cargar y establecer la imagen desde la URL proporcionada
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
