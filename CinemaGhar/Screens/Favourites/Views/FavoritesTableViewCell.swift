//
//  FavoritesTableViewCell.swift
//  CinemaGhar
//
//  Created by pooja kamble on 13/01/26.
//
import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func didTapHeartButton(_ cell: FavoritesTableViewCell)
}

class FavoritesTableViewCell: UITableViewCell {

    static let identifier = "FavoritesTableViewCell"

    weak var delegate: FavoritesTableViewCellDelegate?

    // MARK: - UI Components

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // ❤️ Heart Button
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(heartButton)

        heartButton.addTarget(self,
                              action: #selector(didTapHeart),
                              for: .touchUpInside)

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Constraints

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImageView.widthAnchor.constraint(equalToConstant: 110),
            posterImageView.heightAnchor.constraint(equalToConstant: 160),

            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            heartButton.widthAnchor.constraint(equalToConstant: 28),
            heartButton.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),

            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),

            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),

            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15)
        ])
    }

    // MARK: - Actions

    @objc private func didTapHeart() {
        delegate?.didTapHeartButton(self)
    }

    // MARK: - Configure

    func configure(with model: Favorites) {
        titleLabel.text = model.original_title ?? model.original_name
        ratingLabel.text = "⭐ \(model.vote_average)/10"
        releaseDateLabel.text = model.release_date ?? "N/A"
        overviewLabel.text = model.overview

        if let posterPath = model.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.sd_setImage(with: url)
        }
    }
}
