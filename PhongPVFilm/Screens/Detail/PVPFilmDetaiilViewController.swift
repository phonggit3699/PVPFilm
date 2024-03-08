//
//  PVPFilmDetaiilViewController.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import UIKit
import AVKit


class PVPFilmDetaiilViewController: UIViewController {
    
    @IBOutlet private weak var trailerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: PVPFilmDetaiilViewModel
    
    lazy var playerViewController = AVPlayerViewController()
    
    static func makeScreen(filmId: String, mockId: String, coordinator: PVPFilmDetaiilVCoordinator) -> PVPFilmDetaiilViewController {
        let viewModel = PVPFilmDetaiilViewModel(
            filmId: filmId, 
            mockId: mockId,
            useCase: PVPFilmDetaiilUseCaseDefault(),
            coordinator: coordinator)
        let viewController = PVPFilmDetaiilViewController(viewModel: viewModel)
        return viewController
    }
    
    init(viewModel: PVPFilmDetaiilViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModelState()
        bindViewModelNavigation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerViewController.player?.pause()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction private func tapButtonPlay(_ sender: Any) {
        playerViewController.player?.pause()
        viewModel.action.value = .goToFullScreenFilmPlayer
    }
    
    private func setupUI() {
        playerViewController.videoGravity = .resize
        trailerView.addSubview(playerViewController.view)
        
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        if let playerView = playerViewController.view {
            let constraints = [
                NSLayoutConstraint(item: playerView, attribute: .leading, relatedBy: .equal, toItem: trailerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: playerView, attribute: .trailing, relatedBy: .equal, toItem: trailerView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: playerView, attribute: .top, relatedBy: .equal, toItem: trailerView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: playerView, attribute: .bottom, relatedBy: .equal, toItem: trailerView, attribute: .bottom, multiplier: 1, constant: 0)
                
            ]
            trailerView.addConstraints(constraints)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: PVPFilmDetailDescriptionTBVCell.className, bundle: nil),
            forCellReuseIdentifier: PVPFilmDetailDescriptionTBVCell.className)
        tableView.register(
            UINib(nibName: PVPFilmDetailEpisodeTBVCell.className, bundle: nil),
            forCellReuseIdentifier: PVPFilmDetailEpisodeTBVCell.className)
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func bindViewModelState() {
        viewModel.film.observeNext { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.title = value.filmName
                
                // TODO: Mock api chưa support trả video URL
                if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
                    let player = AVPlayer(url: url)
                    self.playerViewController.player = player
                    player.play()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func bindViewModelNavigation() {
        viewModel.navigation.observeNext { [weak self] navigation in
            guard let self = self,
                  let navigation = navigation
            else { return }
            switch navigation {
            case .showAlert(let message):
                PVPFilmHelper.showAlert(message: message, fromVC: self)
            case .showError(let error):
                PVPFilmHelper.showAlert(error: error, fromVC: self)
            }
        }
    }
}

extension PVPFilmDetaiilViewController {
    enum TableViewSection: Int, CaseIterable {
        case description = 0
        case episodes = 1
    }
}

extension PVPFilmDetaiilViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tbvSection = TableViewSection(rawValue: section) else {
            return 0
        }
        switch tbvSection {
        case .description:
            return 1
        case .episodes:
            return viewModel.film.value.episodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tbvSection = TableViewSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch tbvSection {
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PVPFilmDetailDescriptionTBVCell.className, for: indexPath) as? PVPFilmDetailDescriptionTBVCell else {
                return UITableViewCell()
            }
            cell.bind(description: viewModel.film.value.description)
            return cell
        case .episodes:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PVPFilmDetailEpisodeTBVCell.className, for: indexPath) as? PVPFilmDetailEpisodeTBVCell,
                  let episodeData = viewModel.film.value.episodes[safeIndex: indexPath.row]
            else {
                return UITableViewCell()
            }
            cell.bind(data: episodeData)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
