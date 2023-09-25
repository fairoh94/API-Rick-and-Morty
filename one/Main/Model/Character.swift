import Foundation

// Estructura para decodificar la información de un personaje desde la respuesta JSON
struct Character: Decodable {
    let image: String       // URL de la imagen del personaje
    let name: String        // Nombre del personaje
    let status: String      // Estado del personaje (por ejemplo, "Alive" o "Dead")
    let species: String     // Especie del personaje (por ejemplo, "Human")
    let type: String?       // Tipo del personaje (opcional)
    let gender: String      // Género del personaje (por ejemplo, "Male" o "Female")
    let origin: Origin      // Lugar de origen del personaje
    let location: Location  // Ubicación actual del personaje
}

// Estructura para decodificar la información sobre el lugar de origen de un personaje
struct Origin: Decodable {
    let name: String        // Nombre del lugar de origen
}

// Estructura para decodificar la información sobre la ubicación actual de un personaje
struct Location: Decodable {
    let name: String        // Nombre de la ubicación actual
}
