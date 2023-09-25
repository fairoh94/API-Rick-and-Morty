import Foundation

// Estructura para decodificar la respuesta JSON de la API que contiene información de personajes
struct Response: Decodable {
    let info: Info          // Información general sobre la respuesta
    let results: [Character]  // Lista de personajes
}

// Estructura para decodificar la información general de la respuesta JSON
struct Info: Decodable {
    let pages: Int          // Cantidad de páginas de resultados
    let next: String?       // URL de la página siguiente (si existe)
    let prev: String?       // URL de la página anterior (si existe)
}
