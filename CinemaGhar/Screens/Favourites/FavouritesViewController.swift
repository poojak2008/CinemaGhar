//
//  FavouritesViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 09/01/26.
//

import UIKit

class FavouritesViewController: UIViewController {

    
    private var favorites: [Favorites] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FavoritesTableViewCell.self,
                       forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        table.separatorStyle = .none
        return table
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorites"
           navigationController?.navigationBar.prefersLargeTitles = true

           view.addSubview(tableView)
           tableView.frame = view.bounds
           tableView.rowHeight = 190
           tableView.delegate = self
           tableView.dataSource = self

          
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    private func fetchFavorites() {
        DataPresistenceManager.shared.fetchFavorites { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    self?.favorites = titles
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension FavouritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoritesTableViewCell.identifier,
            for: indexPath
        ) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self
        cell.configure(with: favorites[indexPath.row])

        return cell
    }

}

extension FavouritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let favorite = favorites[indexPath.row]
        print("Selected:", favorite.original_title ?? "")
    }
}



extension FavouritesViewController: FavoritesTableViewCellDelegate {

    func didTapHeartButton(_ cell: FavoritesTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let favorite = favorites[indexPath.row]
        let id = Int(favorite.id)

        DataPresistenceManager.shared.deleteFavorite(with: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.favorites.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)

                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
