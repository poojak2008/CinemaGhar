//
//  HeroPosterCollectionViewCell.swift
//  CinemaGhar
//
//  Created by pooja kamble on 14/01/26.
//
import UIKit
import SDWebImage

class HeroPosterCollectionViewCell: UICollectionViewCell {

    static let identifier = "HeroPosterCollectionViewCell"
    private let gradientLayer = CAGradientLayer()
    private let blurView = UIVisualEffectView()

    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
           setupBlur()
           setupGradientMask()
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupBlur() {
        let style: UIBlurEffect.Style =
            traitCollection.userInterfaceStyle == .dark ? .systemChromeMaterialDark : .systemChromeMaterialLight

        blurView.effect = UIBlurEffect(style: style)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)

        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40) // ⬅️ more area
        ])
    }

    private func setupGradientMask() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor,
            UIColor.black.cgColor
        ]

        gradientLayer.locations = [0.0, 0.55, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        blurView.layer.mask = gradientLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = blurView.bounds
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(
            comparedTo: previousTraitCollection
        ) else { return }

        setupBlur()
    }

    

    func configure(with posterPath: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        imageView.sd_setImage(with: url)
    }
}
