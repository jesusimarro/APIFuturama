//
//  ViewController.swift
//  APIFuturama
//
//  Created by estech on 28/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var personajes:[Modelo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Personajes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "protocell1", for: indexPath) as! MiCelda
        
        let personaje = personajes[indexPath.row]
        
        cell.nombrePersonaje.text = personaje.character
        cell.frasePersonaje.text = personaje.quote
        
        if let imageUrl = URL(string: personaje.image) {
            if let data = try? Data(contentsOf: imageUrl) {
                if let crearImagen = UIImage(data: data) {
                    cell.imagenPersonaje.image = crearImagen
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pasaSegundoVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pasaSegundoVC" {
            let vc = segue.destination as! PersonajeDetalleViewController
            vc.personaje = personajes[tableView.indexPathForSelectedRow!.row]
        }
    }
    

    func downloadData() {

        let urlString = "https://qastusoft.com.es/apis/futurama_quotes.php"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let httpStatus = response as? HTTPURLResponse,
               httpStatus.statusCode != 200 {
                print("El Status Code es \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            if error == nil {
                do {
                    self.personajes = try JSONDecoder().decode([Modelo].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error al descargar los datos de la API")
                }
            }
            
        }.resume()
    }
    
}
