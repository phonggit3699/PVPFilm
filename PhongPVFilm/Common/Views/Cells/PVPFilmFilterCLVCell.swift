//
//  PVPFilmFilterCLVCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

class PVPFilmFilterCLVCell: UICollectionViewCell {
    
    @IBOutlet private weak var filterTitleLabel: UILabel!
    
    func bind(type: PVPFilmFilterType, isSelected: Bool) {
        filterTitleLabel.text = type.title
        filterTitleLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 15, weight: .medium)
    }
}
