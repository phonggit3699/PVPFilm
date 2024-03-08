//
//  PVPFilmFilterView.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

class PVPFilmFilterView: UIView {
    
    @IBOutlet private weak var filterCollectionView: UICollectionView!
    
    var selectedFilterType: PVPFilmFilterType = .film
    var filterTypes: [PVPFilmFilterType] = []
    
    var onSelectedFilterType: ((PVPFilmFilterType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromNib(bundle: nil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadViewFromNib(bundle: nil)
        self.setup()
    }
    
    func setup() {
        filterCollectionView.register(
            UINib(nibName: PVPFilmFilterCLVCell.className, bundle: nil),
            forCellWithReuseIdentifier: PVPFilmFilterCLVCell.className)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func bind(selectedFilterType: PVPFilmFilterType, filterTypes: [PVPFilmFilterType]) {
        self.selectedFilterType = selectedFilterType
        self.filterTypes = filterTypes
        self.filterCollectionView.reloadData()
    }
}

extension PVPFilmFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PVPFilmFilterCLVCell.className, for: indexPath) as? PVPFilmFilterCLVCell,
              let type = filterTypes[safeIndex: indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.bind(type: type, isSelected: type == selectedFilterType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = filterTypes[safeIndex: indexPath.row] else { return }
        selectedFilterType = type
        onSelectedFilterType?(type)
        collectionView.reloadData()
    }
}

extension PVPFilmFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let type = filterTypes[safeIndex: indexPath.row] else { return .zero }
        let isSelected = type == selectedFilterType
        let cellWidth = isSelected ? type.title.width(consideringHeight: 30, font: .systemFont(ofSize: 16, weight: .bold)) : type.title.width(consideringHeight: 30, font: .systemFont(ofSize: 15, weight: .regular))
        return CGSize(width: cellWidth + 24, height: 54)
    }
    
}
