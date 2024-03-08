//
//  PVPFilmDetailDescriptionTBVCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

class PVPFilmDetailDescriptionTBVCell: UITableViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func bind(description: String) {
        descriptionLabel.text = description
    }
}
