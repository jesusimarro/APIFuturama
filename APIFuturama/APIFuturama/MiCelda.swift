//
//  MiCelda.swift
//  APIFuturama
//
//  Created by estech on 30/11/22.
//

import UIKit

class MiCelda: UITableViewCell {

    @IBOutlet weak var nombrePersonaje: UILabel!
    
    @IBOutlet weak var frasePersonaje: UILabel!
    
    @IBOutlet weak var imagenPersonaje: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
