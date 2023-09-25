import UIKit

class DescriptionCharacterViewController: UIViewController {
    // Outlets para las vistas en la interfaz de usuario
    @IBOutlet weak var imagenCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var statusCharacter: UILabel!
    @IBOutlet weak var speciesCharacter: UILabel!
    @IBOutlet weak var genderCharacter: UILabel!
    @IBOutlet weak var originCharacter: UILabel!
    @IBOutlet weak var locationCharacter: UILabel!
    
    // ViewModel del personaje que se mostrará en esta vista
    var characterViewModel: CharacterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Verifica si existe un ViewModel de personaje
        if let characterViewModel = characterViewModel {
            // Configura las vistas con los datos del ViewModel
            nameCharacter.text = characterViewModel.name
            statusCharacter.text = characterViewModel.status
            speciesCharacter.text = characterViewModel.species
            genderCharacter.text = characterViewModel.gender
            originCharacter.text = characterViewModel.origin
            locationCharacter.text = characterViewModel.location

            // Carga la imagen del personaje desde la URL proporcionada en el ViewModel
            if let imageUrl = URL(string: characterViewModel.imageUrl) {
                // Carga la imagen utilizando Kingfisher
                imagenCharacter.kf.setImage(with: imageUrl)
                // Aplica esquinas redondeadas a la imagen
                imagenCharacter.layer.cornerRadius = 15
                imagenCharacter.clipsToBounds = true
            }
        }
    }
}
