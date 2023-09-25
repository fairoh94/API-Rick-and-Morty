import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var photosImageView: UIImageView!
    @IBOutlet weak var photosTitleLabel: UILabel!
    @IBOutlet weak var photosAttributeLabel: UILabel!
    
    // La propiedad characterViewModel se actualiza cuando se asigna un nuevo valor.
    var characterViewModel: CharacterViewModel! {
        didSet {
            // Configura la imagen de la celda utilizando la URL de la imagen del personaje.
            self.photosImageView.setImage(imageUrl: self.characterViewModel.imageUrl)
            
            // Configura los textos de los títulos y atributos de la celda.
            self.photosTitleLabel.text = self.characterViewModel.name
            self.photosAttributeLabel.text = self.characterViewModel.species
        }
    }
}
