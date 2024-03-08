//
//  PVPFilmHomeFilterTBVCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

class PVPFilmHomeFilterTBVCell: UITableViewCell {
    
    @IBOutlet private weak var filterView: PVPFilmFilterView!
    
    var onSelectedFilterType: ((PVPFilmFilterType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterView.onSelectedFilterType = { [weak self] filterType in
            self?.onSelectedFilterType?(filterType)
        }
    }
    
    func bind(selectedFilterType: PVPFilmFilterType) {
        filterView.bind(selectedFilterType: selectedFilterType,
                        filterTypes: PVPFilmFilterType.allCases)
    }
    
}
