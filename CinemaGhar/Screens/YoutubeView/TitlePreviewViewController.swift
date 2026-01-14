//
//  TitlePreviewViewController.swift
//  CinemaGhar
//
//  Created by pooja kamble on 26/12/25.
//

import UIKit
import YouTubeiOSPlayerHelper
class TitlePreviewViewController: UIViewController {

    private var titleModel: Titles?
    
    private let playerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(playerView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(ratingLabel)
        view.addSubview(favouriteButton)
        favouriteButton.addTarget(
            self,
            action: #selector(didTapFavourite),
            for: .touchUpInside
        )

        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    private func configureConstraints() {
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            favouriteButton.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])

    }
    
    private var isFavourite = false

    @objc private func didTapFavourite() {
        isFavourite.toggle()

        let imageName = isFavourite ? "heart.fill" : "heart"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)

        guard let titleModel = titleModel else { return }

        if isFavourite {
            // SAVE
            DataPresistenceManager.shared.favoritesTitleWith(model: titleModel) { result in
                switch result {
                case .success():
                    print("Saved to favourites")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            // DELETE
            DataPresistenceManager.shared.deleteFavorite(with: titleModel.id) { result in
                switch result {
                case .success():
                    print("Removed from favourites")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }




    func configure(with model: TitlePreviewViewModel, title: Titles) {
        self.titleModel = title

        self.title = model.title
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        ratingLabel.text = "⭐ \(model.rating)/10"

        DataPresistenceManager.shared.isFavorite(id: title.id) { [weak self] isFav in
            DispatchQueue.main.async {
                self?.isFavourite = isFav
                let imageName = isFav ? "heart.fill" : "heart"
                self?.favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }

        guard let videoId = model.youtubeView.id.videoId else { return }

        playerView.load(withVideoId: videoId, playerVars: [
            "playsinline": 1,
            "autoplay": 1
        ])
    }


}
