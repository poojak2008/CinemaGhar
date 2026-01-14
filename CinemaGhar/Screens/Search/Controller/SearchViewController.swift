//
//  SearchViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 10/12/25.
//

import UIKit

class SearchViewController: UIViewController {

    private var titles: [Titles] = []

    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.identifier
        )
        return table
    }()

    private lazy var searchController: UISearchController = {
        let resultVC = SearchResultViewController()
        resultVC.delegate = self

        let controller = UISearchController(searchResultsController: resultVC)
        controller.searchBar.placeholder = "Search movies or TV shows"
        controller.searchBar.searchBarStyle = .minimal
        controller.obscuresBackgroundDuringPresentation = true
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true

        definesPresentationContext = true

        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self

        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self

        fetchDiscoverMovies()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

    // MARK: - API

    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.titles = titles
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableViewCell.identifier,
            for: indexPath
        ) as? SearchTableViewCell else {
            return UITableViewCell()
        }

        let title = titles[indexPath.row]
        let model = TitleViewModel(
            title: title.original_title ?? title.original_name ?? "",
            posterURL: title.poster_path ?? "",
            overview: title.overview ?? "",
            voteAverage: title.vote_average
            
        )

        cell.configure(with: model)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let title = titles[indexPath.row]
        let titleName = title.original_title ?? title.original_name ?? ""

        APICaller.shared.getMoviesTrailer(with: titleName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let video):

                    let viewModel = TitlePreviewViewModel(
                        title: titleName,
                        titleOverview: title.overview ?? "",
                        youtubeView: video,
                        rating: title.vote_average,
                        isFavourite: false
                    )

                    let vc = TitlePreviewViewController()
                    vc.configure(with: viewModel, title: title)
                    self?.navigationController?.pushViewController(vc, animated: true)

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard
            let query = searchController.searchBar.text,
            query.trimmingCharacters(in: .whitespaces).count >= 3,
            let resultsVC = searchController.searchResultsController as? SearchResultViewController
        else { return }

        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsVC.titles = titles
                    resultsVC.searchResultCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension SearchViewController: SearchResultViewControllerDelegate {

    func searchResultViewControllerDidSelectTitle(
        _ viewModel: TitlePreviewViewModel,
        titles: Titles
    ) {
        searchController.dismiss(animated: true) {
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel, title: titles)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
