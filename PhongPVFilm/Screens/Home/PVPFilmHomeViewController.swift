//
//  PVPFilmHomeViewController.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import UIKit

class PVPFilmHomeViewController: UIViewController {
    
    @IBOutlet private weak var filmTableView: UITableView!
    
    private let viewModel: PVPFilmHomeViewModel
    
    static func makeScreen(coordinator: PVPFilmHomeCoordinatorDefault) -> PVPFilmHomeViewController {
        let viewModel = PVPFilmHomeViewModel(
            useCase: PVPFilmHomeUseCaseDefault(),
            coordinator: coordinator
        )
        let viewController = PVPFilmHomeViewController(viewModel: viewModel)
        return viewController
    }
    
    init(viewModel: PVPFilmHomeViewModel) {
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
        title = "PhongPVFilm"
        
        filmTableView.delegate = self
        filmTableView.dataSource = self
        filmTableView.register(
            UINib(nibName: PVPFilmHomeTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: PVPFilmHomeTableViewCell.className)
        filmTableView.register(
            UINib(nibName: PVPFilmHomeFilterTBVCell.className, bundle: nil),
            forCellReuseIdentifier: PVPFilmHomeFilterTBVCell.className)
        filmTableView.showsVerticalScrollIndicator = false
    }
    
    private func bindViewModelState() {
        viewModel.filmsByCategories.observeNext { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.filmTableView.reloadData()
            }
        }
        
        viewModel.selectedFilmFilterType.observeNext { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                self?.filmTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
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

extension PVPFilmHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.filmsByCategories.value.count + 1 // +1 section filter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            guard let films =  viewModel.filmsByCategories.value[safeIndex: section]?.films else { return 0 }
            return films.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PVPFilmHomeFilterTBVCell.className, for: indexPath) as? PVPFilmHomeFilterTBVCell
            else {
                return UITableViewCell()
            }
            cell.bind(selectedFilterType: viewModel.selectedFilmFilterType.value)
            
            cell.onSelectedFilterType = { [weak self] filterType  in
                self?.viewModel.action.value = .filterFilmsByCategories(filterType: filterType)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PVPFilmHomeTableViewCell.className, for: indexPath) as? PVPFilmHomeTableViewCell,
                  let filmByCategory =  viewModel.filmsByCategories.value[safeIndex: indexPath.section]
            else {
                return UITableViewCell()
            }
            cell.bind(data: filmByCategory)
            
            cell.onSelectedFilm = { [weak self] id in
                self?.viewModel.action.value = .goToFilmDetail(id: id, mockId: filmByCategory.id)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 54
        } else {
            return 200
        }
    }
}
