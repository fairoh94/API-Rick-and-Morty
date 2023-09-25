import Foundation

// ViewModel para formatear y presentar datos del personaje en la vista
class CharacterViewModel {
    let character: Character

    // Inicializador para recibir un objeto Character y almacenarlo en el ViewModel
    init(character: Character) {
        self.character = character
    }

    // Propiedades para obtener todas las carateristicas del personaje
    var name: String {
        return character.name
    }
    var status: String {
        return character.status
    }
    var species: String {
        return character.species
    }
    var gender: String {
        return character.gender
    }
    var origin: String {
        return character.origin.name
    }
    var location: String {
        return character.location.name
    }
    var imageUrl: String {
        return character.image
    }
}
