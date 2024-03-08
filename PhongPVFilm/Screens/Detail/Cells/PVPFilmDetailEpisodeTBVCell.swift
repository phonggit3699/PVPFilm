//
//  PVPFilmDetailEpisodeTBVCell.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 08/03/2024.
//

import UIKit

class PVPFilmDetailEpisodeTBVCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var episodeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func bind(data: PVPFilmDetailModel.EpisodeInfo) {
        thumbnailImageView.downloadImageFromUrl(url: data.thumbnail, placeHolderImage: UIImage(named: "pvpf_img_bg_horizontal"))
        episodeLabel.text = "Episode \(data.episode)"
        descriptionLabel.text = data.description
    }
}
