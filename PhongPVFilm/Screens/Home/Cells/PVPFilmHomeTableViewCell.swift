//
//  PVPFilmHomeTableViewCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

class PVPFilmHomeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var categoryNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var films: [PVPFilmByCategoryModel.FilmInfo] = []
    
    var onSelectedFilm: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            UINib(nibName: PVPFilmHomeCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: PVPFilmHomeCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing       = 10
        flowLayout.scrollDirection          = .horizontal
        flowLayout.itemSize                 = CGSize(width: 100, height: 149)
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    func bind(data: PVPFilmByCategoryModel) {
        self.films = data.films
        categoryNameLabel.text = data.titleCategory
        collectionView.reloadData()
    }
}

extension PVPFilmHomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PVPFilmHomeCollectionViewCell.className, for: indexPath) as? PVPFilmHomeCollectionViewCell,
              let filmInfo = films[safeIndex: indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.bind(data: filmInfo, isShowName: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filmInfo = films[safeIndex: indexPath.row] else {
            return
        }
        onSelectedFilm?(filmInfo.id)
    }
}
