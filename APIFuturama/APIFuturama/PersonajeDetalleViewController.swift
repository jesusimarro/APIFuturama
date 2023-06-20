//
//  PersonajeDetalleViewController.swift
//  APIFuturama
//
//  Created by estech on 1/12/22.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class PersonajeDetalleViewController: UIViewController {
    
    
    @IBOutlet weak var detalleImage: UIImageView!
    
    @IBOutlet weak var detalleNombre: UILabel!
    
    @IBOutlet weak var detalleFrase: UILabel!
    
    
    var personaje: Modelo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detalleNombre.text = personaje?.character
        detalleFrase.text = personaje?.quote
        
        let imgURL = personaje?.image
        detalleImage.downloaded(from: imgURL!)
        
    }

}
