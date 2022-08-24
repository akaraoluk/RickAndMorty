//
//  CharCell.swift
//  RickAndMorty
//
//  Created by Abdurrahman Karaoluk on 10.05.2022.
//

import UIKit

class CharCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var speciesLabel: UILabel!
    
    @IBOutlet var charImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
