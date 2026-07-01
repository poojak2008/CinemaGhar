//
//  HomeViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 10/12/25.
//

import UIKit

enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {

    var titles: [Titles] = [Titles]()
    let sectionTitle : [String] = ["Trending Movie","Trending TV" ,"Popular","Upcoming Movies","Top Rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeFeedTable)
        view.backgroundColor = .secondarySystemBackground
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        setupHeaderView()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
        
    }
    private func setupHeaderView() {
        let headerView = HeroHederUIView(
            frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500)
            
        )
        headerView.delegate = self

        homeFeedTable.tableHeaderView = headerView

        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    headerView.configure(with: Array(titles.prefix(5)))
                    self.updateHeaderViewHeight()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateHeaderViewHeight() {
        guard let header = homeFeedTable.tableHeaderView else { return }
        header.setNeedsLayout()
        header.layoutIfNeeded()

        let height = header.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        ).height

        var frame = header.frame
        frame.size.height = max(height, 450)
        header.frame = frame

        homeFeedTable.tableHeaderView = header
    }

    
    private func configureNavBar() {
        // Create a custom view for the left side
        let logoImageView = UIImageView(image: UIImage(named: "logo1"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        logoImageView.frame = containerView.bounds
        containerView.addSubview(logoImageView)

        // Assign custom view to left side
        let leftItem = UIBarButtonItem(customView: containerView)
        navigationItem.leftBarButtonItem = leftItem

        // Right-side icons
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .label
    }

}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}
extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 15 , weight: .semibold)
        header.textLabel?.frame = CGRect(x: Int(header.bounds.origin.x) + 20, y: Int(header.bounds.origin.y), width: 100, height: Int(header.bounds.height))
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalaizedFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTV { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpComingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
}

 
    
extension HomeViewController: CollectionViewTableViewCellDelegates {

    func collectionViewTableViewCellDidTapCell(
        _ cell: CollectionViewTableViewCell,
        viewModel: TitlePreviewViewModel,
        title: Titles
    ) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel, title: title) //single Titles
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: HeroHeaderUIViewDelegate {
    func heroHeaderUIViewDidTapItem(_ headerView: HeroHederUIView, title: Titles) {
        
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
}

