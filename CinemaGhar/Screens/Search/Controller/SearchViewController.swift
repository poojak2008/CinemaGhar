//
//  SearchViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 10/12/25.
//

import UIKit

class SearchViewController: UIViewController {

    
    var titles: [Titles] = [Titles]()
    private let discoverTable : UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    private let searchResultVC = SearchResultViewController()

    private lazy var searchController: UISearchController = {
        let resultVC = SearchResultViewController()
        resultVC.delegate = self 

        let controller = UISearchController(searchResultsController: resultVC)
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.dataSource = self
        discoverTable.delegate = self
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
       
        
        fetchDiscoverMovies()
        
    }
    
    private func fetchDiscoverMovies(){
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

    
}

extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else{
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(title: title.original_name ?? title.original_title ?? "" , posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let title = titles[indexPath.row]
        let titleName = title.original_title ?? title.original_name ?? ""

        APICaller.shared.getMoviesTrailer(with: titleName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videoElement):
                    let viewModel = TitlePreviewViewModel(
                        title: titleName,
                        youtubeView: videoElement,
                        titleOverview: title.overview ?? ""
                    )
                    let vc = TitlePreviewViewController()
                    vc.configure(with: viewModel)
                    
                    //Push the view controller
                    self?.navigationController?.pushViewController(vc, animated: true)

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }


    
}
extension SearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
                 !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchResultCollectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension SearchViewController: SearchResultViewControllerDelegate {
    func searchResultViewControllerDidSelectTitle(_ viewModel: TitlePreviewViewModel) {

        searchController.dismiss(animated: true) {   
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
