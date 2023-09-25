//
//  Data.swift
//  one
//
//  Created by SAMUEL HERRERA on 25/09/23.
//

import Foundation
import UIKit


let baseUrl = "https://rickandmortyapi.com/api/character/"
var currentPage = 1             // Página actual de datos que se está cargando
var isLoadingData = false       // booleano para evitar la carga de datos simultánea

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
                print("Main.Async")
                // Agregar los nuevos characterViewModels a la lista existente en lugar de reemplazarla
                self.characters += characterViewModels
                self.currentPage += 1
                print("currentPage")
                self.isLoadingData = false
                self.tableView.reloadData()
            }
        } catch {
            print("Error decoding JSON: \(error)")
            self.isLoadingData = false
        }
    }.resume()
}
