//
//  SearchResultViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 25/12/25.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidSelectTitle(_ viewModel: TitlePreviewViewModel, titles: Titles)
}
class SearchResultViewController: UIViewController {

    var titles : [Titles] = [Titles]()
    weak var delegate: SearchResultViewControllerDelegate?
    
     let searchResultCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10 , height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    


}

extension SearchResultViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.congfigure(with: title.poster_path ?? "hello")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? title.original_name ?? ""
        
        APICaller.shared.getMoviesTrailer(with: titleName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videoElement):
                    
                    let viewModel = TitlePreviewViewModel(
                        title: titleName,
                        titleOverview: title.overview ?? "",
                        youtubeView: videoElement,
                        rating: title.vote_average,
                        isFavourite: false // default
                    )
                    
                    self?.delegate?.searchResultViewControllerDidSelectTitle(viewModel, titles: title)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
extension SearchResultViewController : UICollectionViewDelegate{
    
}
