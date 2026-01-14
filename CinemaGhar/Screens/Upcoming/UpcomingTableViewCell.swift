//
//  TableViewCell.swift
//  CinemaGhar
//
//  Created by pooja kamble on 24/12/25.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "UpcomingTableViewCell"

    // MARK: - UI Components

    private let titlesPosterImages: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titlesPosterImages)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(ratingLabel)

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Constraints

    private func applyConstraints() {
        NSLayoutConstraint.activate([

            // Poster Image
            titlesPosterImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titlesPosterImages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titlesPosterImages.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titlesPosterImages.widthAnchor.constraint(equalToConstant: 100),

            // Title
            titleLabel.topAnchor.constraint(equalTo: titlesPosterImages.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImages.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            // Overview
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Rating
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }

    // MARK: - Configure

    public func configure(with model: TitleViewModel) {

        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") {
            titlesPosterImages.sd_setImage(with: url)
        }

        titleLabel.text = model.title
        overviewLabel.text = model.overview
        ratingLabel.text = "⭐ \(String(format: "%.1f", model.voteAverage)) / 10"
    }
}
