import UIKit

class Main: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseUrl = "https://rickandmortyapi.com/api/character/"
    var currentPage = 1             // Página actual de datos que se está cargando
    var isLoadingData = false       // Booleano para evitar la carga de datos simultánea
    
    var characters: [CharacterViewModel] = []  // Almacena los datos de los personajes en formato ViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar la tabla
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Registrar la celda personalizada
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        
        // Configurar la carga de datos inicial
        self.fetchData()
    }
    
    func fetchData() {
        // Evitar la carga de datos simultánea
        guard !isLoadingData else {
            return
        }
        isLoadingData = true
        
        // Construir la URL con la página actual
        let url = "\(baseUrl)?page=\(currentPage)"
        
        guard let apiUrl = URL(string: url) else {
            isLoadingData = false
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error)")
                self.isLoadingData = false
                return
            }
            
            guard let data = data else {
                self.isLoadingData = false
                return
            }
            
            do {
                // Decodificar la respuesta JSON en un objeto Response
                let response = try JSONDecoder().decode(Response.self, from: data)
                
                // Mapear los personajes a objetos CharacterViewModel
                let characterViewModels = response.results.map { CharacterViewModel(character: $0) }
                
                DispatchQueue.main.async {
                    // Agregar los nuevos characterViewModels a la lista existente en lugar de reemplazarla
                    self.characters += characterViewModels
                    self.currentPage += 1
                    self.isLoadingData = false
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
                self.isLoadingData = false
            }
        }.resume()
    }
}

extension Main: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        // Cargar más datos cuando el usuario esté a 2 pantallas del final
        if offsetY > contentHeight - screenHeight * 2 {
            fetchData()  // Llamar a la función para cargar más datos
        }
    }
}

extension Main: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1  // Solo hay una sección en la tabla
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count  // El número de filas es igual al número de personajes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell {
            // Configurar la celda con los datos del CharacterViewModel correspondiente
            cell.characterViewModel = self.characters[indexPath.row]
            return cell
        }
        return UITableViewCell()  // Devolver una celda vacía si no se puede configurar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Realizar la transición a la vista de detalles cuando se selecciona una celda
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DescriptionCharacterViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            // Pasar el objeto CharacterViewModel seleccionado a la vista de detalles
            let selectedCharacterViewModel = characters[indexPath.row]
            destination.characterViewModel = selectedCharacterViewModel
        }
    }
}
