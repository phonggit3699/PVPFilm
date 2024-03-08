//
//  PVPFilmHomeCollectionViewCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

class PVPFilmHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var filmNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil // reset
    }
    
    func bind(data: PVPFilmByCategoryModel.FilmInfo, isShowName: Bool) {
        thumbnailImageView.downloadImageFromUrl(url: data.thumbnail)
        if isShowName {
            tagLabel.superview?.isHidden = true
            filmNameLabel.superview?.isHidden = false
            filmNameLabel.text = data.filmName
        } else {
            filmNameLabel.superview?.isHidden = true
            let tagType = PVPFilmByCategoryModel.TagType(rawValue: data.tag)
            tagLabel.text = tagType?.title ?? ""
            tagLabel.superview?.isHidden = tagType == nil
        }
    }
}
