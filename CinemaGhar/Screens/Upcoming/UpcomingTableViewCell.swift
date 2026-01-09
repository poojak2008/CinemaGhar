//
//  TableViewCell.swift
//  CinemaGhar
//
//  Created by pooja kamble on 24/12/25.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName:"play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30) )
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let titlesPosterImages: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titlesPosterImages)
        contentView.addSubview(playTitleButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([

            // Poster
            titlesPosterImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titlesPosterImages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterImages.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterImages.widthAnchor.constraint(equalToConstant: 100),

            // Play button (NEVER SHRINKS)
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playTitleButton.widthAnchor.constraint(equalToConstant: 32),
            playTitleButton.heightAnchor.constraint(equalToConstant: 32),

            // Title label (CAN WRAP)
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImages.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }

    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        titlesPosterImages.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
