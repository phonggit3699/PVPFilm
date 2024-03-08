//
//  PVPFilmSearchViewController.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

class PVPFilmSearchViewController: UIViewController {
    
    @IBOutlet private weak var filmCollectionView: UICollectionView!
    
    lazy var uiSearchBar = UISearchController()
    private let viewModel: PVPFilmSearchViewModel
    
    static func makeScreen(coordinator: PVPFilmSearchCoordinator) -> PVPFilmSearchViewController {
        let viewModel = PVPFilmSearchViewModel(
            useCase: PVPFilmSearchUseCaseDefault(),
            coordinator: coordinator)
        let viewController = PVPFilmSearchViewController(viewModel: viewModel)
        return viewController
    }
    
    init(viewModel: PVPFilmSearchViewModel) {
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
    
    private func setupUI() {
        title = "Search"
        uiSearchBar.searchBar.barStyle = .black
        uiSearchBar.searchResultsUpdater = self
        navigationItem.searchController = uiSearchBar
        
        filmCollectionView.register(
            UINib(nibName: PVPFilmHomeCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: PVPFilmHomeCollectionViewCell.className)
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        let cellWitdh = (UIScreen.main.bounds.width - 32 - 24) / 3 // minus spacing leading, trailing, between 3 cell
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing       = 12
        flowLayout.sectionInset             = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.scrollDirection          = .vertical
        flowLayout.itemSize                 = CGSize(width: cellWitdh, height: 158)
        filmCollectionView.collectionViewLayout = flowLayout
    }
    
    private func bindViewModelState() {
        viewModel.films.observeNext { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.filmCollectionView.reloadData()
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

extension PVPFilmSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.films.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PVPFilmHomeCollectionViewCell.className, for: indexPath) as? PVPFilmHomeCollectionViewCell,
              let filmInfo = viewModel.films.value[safeIndex: indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.bind(data: filmInfo, isShowName: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.action.value = .goToFilmDetail(index: indexPath.row)
    }
}

extension PVPFilmSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let debouncer = Debouncer(delay: 0.5)
        debouncer.debounce { [weak self] in
            self?.viewModel.action.value = .typingSearchBar(keyword: text)
        }
    }
}
